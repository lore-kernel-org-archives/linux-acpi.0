From: Nils Spengler <nils.spengler-JAEaK7xBpqGzQB+pC5nmwQ@public.gmane.org>
Subject: Re: problems with acpi (sleep states) on vaio notebook z1sp
Date: Thu, 25 Dec 2003 04:48:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1072324098.23599.2.camel@HuLktop.jimbo.lan>
References: <3ACA40606221794F80A5670F0AF15F8401720C50@PDSMSX403.ccr.corp.intel.com>
	 <1072201432.3134.10.camel@garrett.darkzone>
	 <20031224153617.GI1632@luna.mooo.com> <3FE9DA42.1050909@psu.edu>
	 <20031224224236.GA25026@hell.org.pl>  <3FEA392B.2020206@psu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FEA392B.2020206-8DAjSxpRXgY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Dec 24 19:51:01 variance kernel:  hwsleep-0257 [33] 
> acpi_enter_sleep_state: Entering sleep state [S3]
> Dec 24 19:51:01 variance kernel: Back to C!
> Dec 24 19:51:01 variance kernel: PM: Finishing up.
> Dec 24 19:51:01 variance kernel: hda: Wakeup request inited, waiting 
> for !BSY...
> Dec 24 19:51:01 variance kernel: hda: start_power_step(step: 1000)
> Dec 24 19:51:01 variance kernel: blk: queue cf568e00, I/O limit 
> 4095Mb (mask 0xf
> fffffff)
> Dec 24 19:51:01 variance kernel: hda: completing PM request, resume
> Dec 24 19:51:01 variance kernel: hdc: Wakeup request inited, waiting 
> for !BSY...
> Dec 24 19:51:01 variance kernel: hdc: start_power_step(step: 1000)
> Dec 24 19:51:01 variance kernel: hdc: completing PM request, resume
> Dec 24 19:51:01 variance kernel: Restarting tasks... done
> 
> I don't see anything suspicious here.. please let me know if you see 
> something...
> 
> Thanks,
> nirmal
i personally do not come to this point. i get an error about could not
resume or something like that.
i made several kernels until now, i tried every possible combinations
and tried to get the most minimalistic kernel possible (i hope). i
completely disabled usb and fiwi support. i also tried apm instead of
acpi but it ended with the same results.
i played around with the preemtible kernel and other new improvements of
kernel 2.6 (whether they have something to do with power managment or
not). but i always get the same results.
there is something i really would like to know. why does these things
work that flawlessly in windows but not in linux? does this have
something to do with vendor specific drivers that are only provided in
windows? does windows use other standards than linux?
the problem is that power managment is (at least for me) the most
important things on laptops. linux provides that many advantages that
i'm not willing to switch to windows only because of pm but this is
really a crappy situation.
is there any hope that these things will work in the future or are there
any other possibilities to debug pm or to support the developers in any
way?

greets,
nils



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
