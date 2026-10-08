<template>
  <div class="slidev-layout default w-full h-full p-0 flex flex-col bg-white">
    <header
      class="w-full bg-[#1a2a5a] h-28 flex items-center justify-between px-12 border-b-[6px] border-[#c8a048] relative z-20 shadow-md"
    >
      <div class="text-white text-4xl font-bold font-sans">
        <slot name="header" />
      </div>

      <div class="flex flex-col items-center">
        <img src="/assets/header.png" class="h-15 filter" />
      </div>
    </header>

    <main class="flex-1 w-full relative p-6 overflow-hidden">
      <div
        class="absolute inset-0 opacity-40 flex justify-center items-center pointer-events-none"
      >
        <img
          src="/assets/ekke.png"
          class="w-2/3 filter opacity-30 object-contain"
        />
      </div>

      <div class="relative z-10 text-[#1a2a5a]">
        <slot name="default" />
      </div>
    </main>
  </div>
</template>
