From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Build PST for AthlonXP
Date: Fri, 6 Feb 2004 17:37:41 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206163741.GA13262@poupinou.org>
References: <15986.1075989680@www48.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15986.1075989680-QaGsrjdPBgFmcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lukas Schrangl <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2004 at 03:01:20PM +0100, Lukas Schrangl wrote:
> > On Thu, Feb 05, 2004 at 08:17:53AM +0100, Lukas Schrangl wrote:

> > > to read the powernow- states from ACPI.
> > 
> > Let me guess.  The one that is before the latest state, and actually
> > you meant the VID value which is a little too high?
> > 
> > If that's the case, it should be safe to go, but yes, I
> > have to workaround that though.  But if that's really the FID
> > which is wrong, well, I will be gratefull to get a report.
> 
> I think it's really the FID in the state one before the last state which was
> too low by one but I will look that up to be shure (I'm not working with my
> computer). I will notify you as soon as I have looked that up and got to a
> computer with internet access again.

Well, well. Ok.

> > the laptop is DMI blacklisted (and ACPI processor is compiled,
> > of course).
> 
> Don't think it is blacklisted, but didn't try your patch yet. Will do that
> as soon as possible.

If you want, you can test that dummy module instead.  Nothing will
be actually touched.  You need at least a 2.6.2-rc3-mm1, or a
recent ACPI test bk tree (this module is actually an hack of a module
made by Dominik).

Create a Makefile with that line:
obj-m = test-powernow.o
then
make -C /lib/modules/`uname -r`/build SUBDIRS=`pwd` modules
insmod ./test-powernow.ko

It will failed, but dmesg will give you the table.  You need to
have CONFIG_ACPI_PROCESSOR enabled, though.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test-powernow.c"

/*
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/cpufreq.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <asm/uaccess.h>

#include <linux/acpi.h>
#include <acpi/processor.h>

struct acpi_processor_performance p;

union powernow_acpi_control_t {
	struct {
		unsigned long fid:5,
		vid:5,
		sgtc:20,
		res1:2;
	} bits;
	unsigned long val;
};

#define ACPI_PDC_REVISION_ID                   0x1
#define ACPI_PDC_CAPABILITY_ENHANCED_SPEEDSTEP 0x1

static int __init
acpi_cpufreq_init (void)
{
	unsigned int i;
	struct acpi_pct_register *r;
	union powernow_acpi_control_t pc;

	if (acpi_processor_register_performance(&p, 0))
		return -EIO;

	printk("number of states: %d\n", p.state_count);
	for (i=0; i< p.state_count; i++) {
		pc.val = (unsigned long) p.states[i].control;
		printk(KERN_INFO "powernow: %cP%d: %d MHz, %d mW, %d uS, control %08x, status %08x, vid: %02x fid: %02x SGTC: %d\n",
		       (i == p.state?'*':' '), i,
		       (u32) p.states[i].core_frequency,
		       (u32) p.states[i].power,
		       (u32) p.states[i].transition_latency,
		       (u32) p.states[i].control,
		       (u32) p.states[i].status,
		       pc.bits.vid,
		       pc.bits.fid,
		       pc.bits.sgtc);

	}

	printk("control_register:\n");
	r = &p.control_register;
	printk("%d %d %d %d %d %d %lld\n", r->descriptor, r->length, r->space_id,
	       r->bit_width, r->bit_offset, r->reserved, r->address);

	printk("status_register:\n");
	r = &p.status_register;
	printk("%d %d %d %d %d %d %lld\n", r->descriptor, r->length, r->space_id,
	       r->bit_width, r->bit_offset, r->reserved, r->address);

	acpi_processor_unregister_performance(&p, 0);

	return -ENODEV;
}


static void __exit
acpi_cpufreq_exit (void)
{
	return;
}


late_initcall(acpi_cpufreq_init);
module_exit(acpi_cpufreq_exit);

--4Ckj6UjgE2iN1+kY--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
