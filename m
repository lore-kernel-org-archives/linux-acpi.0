From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] ACPI / scan: Remove useless #ifndef and simplify container driver
Date: Fri, 08 Feb 2013 13:46:40 +0100
Message-ID: <3432353.MRsevDcPKP@vostro.rjw.lan>
References: <1873429.MS5RQDxTye@vostro.rjw.lan> <1468930.acVuhKfKYv@vostro.rjw.lan> <51146EC7.5090504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51146EC7.5090504@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, February 08, 2013 12:19:35 PM Yasuaki Ishimatsu wrote:
> Hi Rafael,
> 
> 2013/02/08 9:24, Rafael J. Wysocki wrote:
> > On Monday, February 04, 2013 12:47:31 AM Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The only useful thing that the ACPI container driver does is to
> >> install system notify handlers for all container and module device
> >> objects it finds in the namespace.  The driver structure,
> >> acpi_container_driver, and the data structures created by its
> >> .add() callback are in fact not used by the driver, so remove
> >> them entirely.
> >>
> >> It also makes a little sense to build that driver as a module,
> >> so make it non-modular and add its initialization to the
> >> namespace scanning code.
> >>
> >> In addition to that, make the namespace walk callback used for
> >> installing the notify handlers more straightforward.
> >
> > As pointed out by Toshi Kani, the above changes would make acpi_eject_store()
> > fail for containers and it is the only way to eject them currently, so patch
> > [2/2] is an improved version of this (with Toshi's changes folded in).
> >
> > Patch [1/2] is just a cleanup removing a useless #ifndef from acpi_eject_store().
> 
> I confimed the patch series works well.
> 
> Acked-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Tested-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks a lot!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
