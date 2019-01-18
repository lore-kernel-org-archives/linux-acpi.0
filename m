From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Date: Fri, 18 Jan 2019 10:45:31 +0100
Message-ID: <CAJZ5v0jzTz9MK1krWgfHXNhqNCY_ftotbCpupJHOtPMysbNPwQ@mail.gmail.com>
References: <20190115095834.22617-1-kasong@redhat.com> <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic> <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic> <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190117085316.GA17940@dhcp-128-65.nay.redhat.com> <CAJZ5v0hb6Lz0knzNFTZKNb863bvDx2a1EFjTjOG2NdvyyyhniQ@mail.gmail.com>
 <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPcB9eomuBPmxCEWEutt1gxO3=nrFFuYtKeANd0+h8DsN7M3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kairui Song <kasong@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@alien8.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 18, 2019 at 5:47 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Thu, Jan 17, 2019 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 17, 2019 at 9:53 AM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Add linux-acpi list
> >
> > Well, thanks, but please resend the patches with a CC to linux-acpi.
> >
>
> Hi, sure will do.
> Any thought on adding an acpi_os_get_root_pointer_late and store rsdp
> pointer as mentioned?

It is a good idea in general IMO, but all depends on how the code
changes will look like.

> Will updat the patch and post V2, and cc linux-acpi as well later.

Thanks!
