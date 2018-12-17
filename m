From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v10 3/6] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
Date: Mon, 17 Dec 2018 18:00:57 +0100
Message-ID: <20181217170056.GA20499@gmail.com>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-4-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181215010247.26101-4-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Otavio Pontes <otavio.pontes@intel.com>, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Sinan Kaya <okaya@kernel.org> wrote:

> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # PCI parts

If this is targeted for the ACPI tree:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
