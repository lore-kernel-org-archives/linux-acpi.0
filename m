From: "Shay Elkin" <shayel-NSemkxREmS1YZAO8hgG6+w@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Wed, 25 Sep 2002 18:26:34 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2002.09.25.15.26.32.102013@cs.huji.ac.il>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE80@orsmsx119.jf.intel.com> <200209192208.40254.jbr.1@gmx.net> <200209192215.g8JMEv306270@pfn1.pefnos> <200209221321.g8MDLb009922@pfn1.pefnos> <20020922005310.B35@toy.ucw.cz> <20020923150937.GA12513@dutidad.twi.tudelft.nl> <20020922043148.B35@toy.ucw.cz> <20020924213334.GB22018@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 24 Sep 2002 23:33:34 +0200, Charl P. Botha wrote:

> On Sun, Sep 22, 2002 at 04:31:48AM +0000, Pavel Machek wrote:
>> > On Sun, Sep 22, 2002 at 12:53:10AM +0000, Pavel Machek wrote:
>> > > can we remove /proc/acpi/sleep so users don't waste time trying to
>> > > make s3/s4 work in 2.4.x?
>> Do you think you could produce patch to do just that? printk() on S4 if
>> not config_software_suspend and printk() on S3 under 2.4.X is the best
>> way to go. Unfortunately I do not have 2.4.X tree easily available...
> I would like to, but I'm still running acpi 20020726, mostly due to swsusp
> and such-like.  Seeing that hard working hackers have graced us with
> 2.4.18 + 20020918 + swsusp 12, I am considering upgrading... as soon as
> I've done this I could make a patch.  This might take a while, with
> RealLife(tm) taking inordinate amounts of time at the moment.

Is something along the attached patch is okay, or should it be done in
acpi_suspend() instead? (I don't think acpi_suspend is called from anywhere
else but acpi_system_write_sleep()).

	Shay.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
