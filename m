From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: S3 hangs Sony Notebook
Date: Wed, 12 Nov 2003 18:44:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068646281.4639.31.camel@litshi.luna.local>
References: <1068584857.1419.11.camel@garrett.darkzone>
	 <1068588639.25527.19.camel@litshi.luna.local>
	 <1068636191.6719.24.camel@garrett.darkzone>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1068636191.6719.24.camel-NZYYv2kObinUTSZfUHD3qA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2003-11-12 at 13:23, Martin Emrich wrote:
> Am Di, den 11.11.2003 schrieb Micha Feigin um 23:10:
> > On Tue, 2003-11-11 at 23:07, Martin Emrich wrote:
> 
> > p3 450 sounds a bit old for acpi support but its possible (got a celron
> > 450 hp to work but it needed a new bios).
> 
> Yes, but W2k works fine with ACPI, including S3 and BIOS-S4 (to a
> Bios-used partition). 
> 
> > I have fxa-53 (athelon 1.3G) and acpi works but the dsdt table had to be
> > replaced due to bugs.
> 
> I think this might help me, too. How difficult is this? I heard that I
> have to learn some ACPI-Assembly-Language thingy, and I have of course
> to know what to patch in there...
> 

Depends on how problematic you dsdt is.
For the basic stuff I didn't need to know anything. I followed the dsdt
links on the acpi site to the tools and an explanation on how to copy
and recompile the dsdt. One of the sites linked from there gives you
details on how to solve to common compile errors.
I had a problem with reporting the ac status but some grepping through
the file a comparing to the things that work I found out a solution. It
mostly depends on how good you are with partially understanding code in
a language you don't know.

> > > - When entering S3 state, some lines appear (something about hda, it is
> > > gone too fast to read), then the screen blanks and the power LED blinks
> > > red slowly, just like with Suspend-To-RAM in APM mode (which works fine
> > > btw.). But then I can't turn it on again, neither can I turn it off. I
> > > have to unplug the PSU and remove the battery to turn it off completely.
> > > (IIRC somebody posted the same problem with a Dell notebook some time
> > > ago).
> > > 
> > 
> > S3 state is very difficult to implement. Most of the work is currently
> > done on s4 state since its easier to implement.
> > It will probably be some time before S3 will function properly.
> 
> So it might be as well not my notebook's fault, but just that the S3
> code is not yet ready to work?
> 

AFAIK its more probably the S3 code. I don't know how much work was
actually done on it.

> > If S4 doesn't work with 2.6 you could try the swsusp version
> > (swsusp.sourceforge.net) there is an alpha version for 2.6 and a mostly
> > stable version for 2.4 (a few issues but in most cases stable)
> 
> Where does Linux save the RAM contents? I'm not interested in the kernel
> overwriting the first 260MB of my Harddrive... 
> 

Linux saves the ram contents to the swap partition. The is partial
support for swapfiles. Mostly working but not very well documented. Has
some issues in some cases.
You will need to have enough room on you swap space and specify the swap
partition to resume from (actually one of them the actual image isn't
necessarily on that partition. you can give it in lilo as if not suspend
image is found it just does a regular boot).
Notice that there are currently two implementation of swsusp I know of,
which should merge at some time in the future. There is the 2.6 builtin
version and the swsusp patch (swsusp.sourceforge.net). Couldn't get the
first to work for me.

> > You need to make sure you use hwclock to save system clock to hw be
> > shutdown/suspend and restore it on resume (should be set up by the
> > distribution). I don't think acpi should have anything to do with the
> > clock.
> 
> I'll keep an eye on it...
> 
> According to bogomips, CPU throttling works, after echo 7 >
> /proc/acpi/processor/CPU0/throttling, it has only 1/10 of the bogomips.
> 
> Ciao
> 
> Martin
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: ApacheCon 2003,
> 16-19 November in Las Vegas. Learn firsthand the latest
> developments in Apache, PHP, Perl, XML, Java, MySQL,
> WebDAV, and more! http://www.apachecon.com/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
