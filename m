From: Gabriel C <nix.or.die@gmail.com>
Subject: Re: [Kernel 5.1] ACPI_DEBUG messages without CONFIG_ACPI_DEBUG being set
Date: Tue, 7 May 2019 09:32:53 +0200
Message-ID: <CAEJqkgiNYXwsJaT0d3JyMW-2yJ2DV53FHPV5-iAy7b-NbAEAcw@mail.gmail.com>
References: <CAEJqkgh-eh0F0rNBChhurH0LWTLFP0DyfFzKj66p4Z2d1kM2gw@mail.gmail.com>
 <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gRWEL1shQE3im0VxiPRBYat86o=R_NVQbc3JgOX8uT6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Schmauss, Erik" <erik.schmauss@intel.com>
List-Id: linux-acpi@vger.kernel.org

Am Di., 7. Mai 2019 um 09:01 Uhr schrieb Rafael J. Wysocki <rafael@kernel.org>:
>
 Hello Rafael ,  Erik

> +Erik
>
> On Tue, May 7, 2019 at 1:33 AM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Hello,
> >
> > while testing kernel-5.1 I get on one of my Lenovo Laptops very
> > strange 'ACPI Debug:' messages.
> >
> > After some grepping I realized these are Debug messages from DSDT ,
> > however my kernel does
> > not have ACPI_DEBUG enabled.
> >
> > I found out the module triggering this, on this Laptop is
> > ideapad_laptop , but looking at the code
> > I cannot see what would causes that.
> >
> > Also on the same Laptop with any 5.0.X kernels I cannot see these.
> >
> >
> > ~$ grep -i ACPI_DEBUG /boot/config-5.1-fw1
> > # CONFIG_ACPI_DEBUGGER is not set
> > # CONFIG_ACPI_DEBUG is not set
> > # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> > # CONFIG_THINKPAD_ACPI_DEBUG is not set
> >
> > .. dmesg ..
> > ...
> > [   68.020812] calling  ideapad_acpi_driver_init+0x0/0x1000
> > [ideapad_laptop] @ 1322
> > [   68.026708] input: Ideapad extra buttons as
> > /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/VPC2004:00/input/input16
> > [   68.038236] ACPI Debug:  "=====QUERY_64====="
> > [   68.050232] ACPI Debug:  "=====QUERY_65====="
> > [   68.060218] ACPI Debug:  "=====QUERY_64====="
> > [   68.092216] probe of VPC2004:00 returned 1 after 71386 usecs
> > [   68.092245] initcall ideapad_acpi_driver_init+0x0/0x1000
> > [ideapad_laptop] returned 0 after 69751 usecssg
> >
> > ...
> >
> > These =====QUERY_XX===== messages are from DSDT:
> >
> > ~/acpi$ grep QUERY dsdt.dsl
> >                Debug = "=====QUERY_11====="
> >                Debug = "=====QUERY_12====="
> >                Debug = "=====QUERY_24====="
> >                Debug = "=====QUERY_25====="
> >                Debug = "=====QUERY_37====="
> >                Debug = "=====QUERY_38====="
> >                Debug = "=====QUERY_64====="
> >                Debug = "=====QUERY_65====="
> >
> > Also this is the code from DSDT for QUERY 64 and 65:
> >
> > ...
> >             Method (_Q64, 0, NotSerialized)  // _Qxx: EC Query
> >            {
> >                Debug = "=====QUERY_64====="
> >                If ((OSYS == 0x07D9))
> >                {
> >                    If (((WLEX == One) & (WLAT == One)))
> >                    {
> >                        SGOV (0x02040005, One)
> >                    }
> >                    Else
> >                    {
> >                        SGOV (0x02040005, Zero)
> >                    }
> >                }
> >            }
> >
> >            Method (_Q65, 0, NotSerialized)  // _Qxx: EC Query
> >            {
> >                Debug = "=====QUERY_65====="
> >                If ((OSYS == 0x07D9))
> >                {
> >                    If (((BTEX == One) & (BTAT == One)))
> >                    {
> >                        SGOV (0x0202000B, One)
> >                    }
> >                    Else
> >                    {
> >                        SGOV (0x0202000B, Zero)
> >                    }
> >                }
> >            }
> >
> > ...
> >
> >
> > Any idea what would cause this ?

I think I found what is causing that.

Commit aa9aaa4d61c0048d3faad056893cd7860bbc084c is moving
definition of Linux's  ACPI_DEBUG_DEFAULT to incude/acpi/platform/aclinux.h ,
however include/acpi/acpi.h didn't got updated and  ACPI_DEBUG_DEFAULT now
being always defined as  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT |
ACPI_LV_EVALUATION | ACPI_LV_REPAIR)

BR,

Gabriel C
