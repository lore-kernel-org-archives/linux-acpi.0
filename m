From: James D Strandboge <jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org>
Subject: Re: performance problems?
Date: 19 Nov 2002 10:59:43 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1037721583.1432.12.camel@sirius.strandboge.cxm>
References: <Pine.LNX.4.44.0211191552030.31104-100000@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0211191552030.31104-100000-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2002-11-19 at 09:54, Markus Gaugusch wrote:
> On Nov 19, Loic Jaquemet <ljaquemet-BNG0eM9rGRi0IRkH3yUr9EW4647UYGdYQQ4Iyu8u01E@public.gmane.org> wrote:
> > i'am using 2.4.19 + around october patch ( I'll check that this evening )
> > on sony vaio fx502
> > [...]
> > when I fetch the /proc/acpi/<batteriesxxx>/state|info files, I get a 1-2
> > second freeze| lag ..
> > [...]
> > I'm not sure, but i think i didn't have this problem on pre-september
> > patches ..
> No, it has been present before. I have an FX405 and can't use any battery
> monitor applet that reads the info file. Even a 'cat
> /proc/acpi/battery/BAT1/info' causes a noticable peak in my cpu monitor
> (kernel time). At least, it doesn't freeze keyboard anymore, thanks to the
> ACPI people!
> 

You want to poll /proc/acpi/battery/BAT1/state or whatever is correct
for your battery.  Polling info requires interrupts with the BIOS I
think, and state is there for a quick poll.  At least on my machine this
is the case.  

Perhaps someone would want to clarify the difference and why info causes
a hang and state does not.

Jamie Strandboge


-- 
Email:        jstrand1-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

Visit Perinton Nursery School at:
http://perintonnurseryschool.org/



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
