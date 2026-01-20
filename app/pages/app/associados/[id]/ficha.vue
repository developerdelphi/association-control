<script setup lang="ts">
const route = useRoute()
const { data: associado, pending, error } = await useFetch(`/api/app/associados/${route.params.id}`)

const print = () => {
  window.print()
}

// Helper to format date
const formatDate = (date: string | Date | null) => {
  if (!date) return '-'
  return new Date(date).toLocaleDateString('pt-BR')
}
</script>

<template>
  <div class="max-w-[210mm] mx-auto bg-white p-8 min-h-screen print:p-0 print:shadow-none shadow-lg">
    <!-- Actions (Hidden on Print) -->
    <div class="flex justify-between mb-8 print:hidden">
      <UButton icon="i-heroicons-arrow-left" variant="ghost" to="/app/associados" label="Voltar" />
      <UButton icon="i-heroicons-printer" color="primary" @click="print" label="Imprimir Ficha" />
    </div>

    <div v-if="pending" class="flex justify-center py-12">
      <UIcon name="i-lucide-loader-2" class="animate-spin text-3xl" />
    </div>

    <div v-else-if="error" class="text-red-500 text-center">
      Erro ao carregar dados do associado.
    </div>

    <div v-else class="space-y-6 text-sm text-gray-900">
      
      <!-- Header -->
      <header class="flex items-center gap-6 border-b-2 border-gray-200 pb-6">
        <div v-if="associado.associacao?.logo" class="w-24 h-24 flex-shrink-0">
           <img :src="associado.associacao.logo" class="w-full h-full object-contain" alt="Logo Associação" />
        </div>
        <div class="flex-1">
          <h1 class="text-2xl font-bold uppercase">{{ associado.associacao?.name || 'Associação' }}</h1>
          <p class="text-gray-500" v-if="associado.associacao?.cnpj">CNPJ: {{ associado.associacao.cnpj }}</p>
          <h2 class="text-xl font-semibold mt-2 text-primary-700">Ficha Cadastral do Associado</h2>
        </div>
        <div class="text-right">
           <p class="font-bold text-lg">Matrícula</p>
           <p class="text-2xl font-mono">{{ associado.registerNumber || 'N/A' }}</p>
        </div>
      </header>

      <!-- Main Content Grid -->
      <div class="grid grid-cols-12 gap-6">
          
          <!-- Photo & Basic Identity -->
          <div class="col-span-3 flex flex-col items-center gap-4">
              <div class="w-full aspect-[3/4] border-2 border-gray-200 rounded-lg overflow-hidden bg-gray-50 flex items-center justify-center">
                  <img v-if="associado.photo" :src="associado.photo" class="w-full h-full object-cover" />
                  <UIcon v-else name="i-heroicons-user" class="text-6xl text-gray-300" />
              </div>
              <div class="text-center w-full">
                  <span class="inline-block px-3 py-1 rounded-full text-xs font-bold uppercase border"
                        :class="associado.status === 'ativo' ? 'bg-green-50 border-green-200 text-green-700' : 'bg-red-50 border-red-200 text-red-700'">
                      {{ associado.status }}
                  </span>
              </div>
          </div>

          <!-- Personal Data -->
          <div class="col-span-9 space-y-6">
              
              <!-- Section: Dados Pessoais -->
              <section>
                  <h3 class="font-bold text-gray-900 border-b border-gray-200 mb-3 pb-1 uppercase text-xs tracking-wider">Dados Pessoais</h3>
                  <div class="grid grid-cols-2 gap-y-2 gap-x-4">
                      
                      <div class="col-span-2">
                        <span class="block text-xs text-gray-500 font-semibold">Nome Completo</span>
                        <span class="block text-base font-medium">{{ associado.name }}</span>
                      </div>

                      <div>
                          <span class="block text-xs text-gray-500 font-semibold">Tipo de Associado</span>
                          <span>{{ associado.type }}</span>
                      </div>
                      
                      <div>
                          <span class="block text-xs text-gray-500 font-semibold">Data de Admissão</span>
                          <span>{{ formatDate(associado.entryDate) }}</span>
                      </div>

                      <div v-if="associado.qualificacao">
                          <span class="block text-xs text-gray-500 font-semibold">Nacionalidade</span>
                          <span>{{ associado.qualificacao.nationality }} <span v-if="associado.qualificacao.isForeigner" class="text-xs text-gray-400">(Estrangeiro)</span></span>
                      </div>

                      <div v-if="associado.qualificacao">
                          <span class="block text-xs text-gray-500 font-semibold">Estado Civil</span>
                          <span>{{ associado.qualificacao.civilStatus }}</span>
                      </div>

                      <div v-if="associado.qualificacao">
                         <span class="block text-xs text-gray-500 font-semibold">Profissão</span>
                         <span>{{ associado.qualificacao.profession }}</span>
                      </div>
                  </div>
              </section>

               <!-- Section: Documentação -->
              <section v-if="associado.qualificacao">
                  <h3 class="font-bold text-gray-900 border-b border-gray-200 mb-3 pb-1 uppercase text-xs tracking-wider">Documentação</h3>
                  <div class="grid grid-cols-3 gap-y-2 gap-x-4">
                      <div>
                          <span class="block text-xs text-gray-500 font-semibold">CPF</span>
                          <span>{{ associado.qualificacao.cpf || '-' }}</span>
                      </div>
                      <div>
                          <span class="block text-xs text-gray-500 font-semibold">RG</span>
                          <span>{{ associado.qualificacao.rg || '-' }}</span>
                      </div>
                      <div v-if="associado.qualificacao.isForeigner">
                          <span class="block text-xs text-gray-500 font-semibold">RNE</span>
                          <span>{{ associado.qualificacao.rne || '-' }}</span>
                      </div>
                  </div>
              </section>
          </div>
      </div>

      <!-- Section: Filiação e Cônjuge -->
       <section v-if="associado.qualificacao">
            <h3 class="font-bold text-gray-900 border-b border-gray-200 mb-3 pb-1 uppercase text-xs tracking-wider">Filiação e Família</h3>
            <div class="grid grid-cols-2 gap-y-2 gap-x-4">
                <div>
                     <span class="block text-xs text-gray-500 font-semibold">Nome do Pai</span>
                     <span>{{ associado.qualificacao.fatherName || '-' }}</span>
                </div>
                 <div>
                     <span class="block text-xs text-gray-500 font-semibold">Nome da Mãe</span>
                     <span>{{ associado.qualificacao.motherName || '-' }}</span>
                </div>
                 <div class="col-span-2" v-if="associado.qualificacao.spouseName">
                     <span class="block text-xs text-gray-500 font-semibold">Cônjuge</span>
                     <span>{{ associado.qualificacao.spouseName }}</span>
                </div>
            </div>
       </section>

      <!-- Section: Contato e Endereço -->
      <section>
          <h3 class="font-bold text-gray-900 border-b border-gray-200 mb-3 pb-1 uppercase text-xs tracking-wider">Localização e Contato</h3>
          
          <div class="grid grid-cols-1 gap-4">
              <!-- Endereços -->
              <div v-for="(end, index) in associado.enderecos" :key="index" class="text-sm">
                   <div class="font-semibold text-gray-700 mb-1 flex items-center gap-2">
                      <UIcon name="i-heroicons-map-pin" class="w-4 h-4" /> Endereço {{ end.description ? `(${end.description})` : '' }}
                   </div>
                   <p>{{ end.logradouro }}, {{ end.numero }} <span v-if="end.complemento"> - {{ end.complemento }}</span></p>
                   <p>{{ end.bairro }} - {{ end.cidade }}/{{ end.uf }}</p>
                   <p>CEP: {{ end.cep }}</p>
              </div>

              <!-- Contatos -->
              <div v-if="associado.contatos?.length" class="mt-2">
                  <div class="font-semibold text-gray-700 mb-1 flex items-center gap-2">
                      <UIcon name="i-heroicons-phone" class="w-4 h-4" /> Contatos
                   </div>
                  <div class="flex flex-wrap gap-4">
                      <div v-for="contato in associado.contatos" :key="contato.id" class="bg-gray-50 px-3 py-1 rounded border">
                          <span class="text-xs text-gray-500 uppercase mr-1">{{ contato.type }}:</span>
                          <span class="font-medium">{{ contato.value }}</span>
                      </div>
                  </div>
              </div>
          </div>
      </section>

      <!-- Section: Dados Bancários -->
      <section v-if="associado.dadosBancarios">
           <h3 class="font-bold text-gray-900 border-b border-gray-200 mb-3 pb-1 uppercase text-xs tracking-wider">Dados Financeiros</h3>
           <div class="grid grid-cols-3 gap-4 bg-gray-50 p-4 rounded-lg border border-gray-200">
                <div class="col-span-3 md:col-span-3">
                   <span class="block text-xs text-gray-500 font-semibold">Conta BDM Digital</span>
                   <span class="font-mono text-base">{{ associado.dadosBancarios.bdmDigitalAccount || '-' }}</span>
                </div>
                <div>
                   <span class="block text-xs text-gray-500 font-semibold">Banco</span>
                   <span>{{ associado.dadosBancarios.bank || '-' }}</span>
                </div>
                 <div>
                   <span class="block text-xs text-gray-500 font-semibold">Agência</span>
                   <span>{{ associado.dadosBancarios.agency || '-' }}</span>
                </div>
                 <div>
                   <span class="block text-xs text-gray-500 font-semibold">Conta</span>
                   <span>{{ associado.dadosBancarios.accountNumber || '-' }}</span>
                </div>
           </div>
      </section>

      <!-- Footer -->
      <footer class="mt-12 pt-8 border-t border-gray-200 text-center text-xs text-gray-400">
          <p>Documento gerado em {{ new Date().toLocaleString() }}</p>
      </footer>

  </div>
  </div>
</template>

<style scoped>
@media print {
  @page {
    margin: 0;
    size: auto;
  }
  body {
    -webkit-print-color-adjust: exact;
  }
}
</style>
