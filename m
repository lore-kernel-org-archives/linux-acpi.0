From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v10 3/6] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
Date: Tue, 18 Dec 2018 02:57:14 +0100
Message-ID: <CAK9iUCN0UWRm94qiFop0Tv=i8-uZnpBkMZkXMTz-jDBke45MZw@mail.gmail.com>
References: <20181215010247.26101-1-okaya@kernel.org> <20181215010247.26101-4-okaya@kernel.org>
 <20181217170056.GA20499@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217170056.GA20499@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Otavio Pontes <otavio.pontes@intel.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, open list:PCI
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 17, 2018 at 6:01 PM Ingo Molnar <mingo@kernel.org> wrote:
&gt;
&gt;
&gt; * Sinan Kaya <okaya@kernel.org> wrote:
&gt;
&gt; &gt; We are compiling PCI code today for systems with ACPI and no PCI
&gt; &gt; device present. Remove the useless code and reduce the tight
&gt; &gt; dependency.
&gt; &gt;
&gt; &gt; Signed-off-by: Sinan Kaya <okaya@kernel.org>
&gt; &gt; Acked-by: Bjorn Helgaas <bhelgaas@google.com> # PCI parts
&gt;
&gt; If this is targeted for the ACPI tree:
&gt;

Thanks, yes. Plan is to take it through ACPI tree.

> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> Thanks,
>
>         Ingo
