From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S1bios
Date: Tue, 11 Mar 2003 21:50:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030311205039.GH28131@poup.poupinou.org>
References: <E18sfx5-0001dg-00@incognito>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E18sfx5-0001dg-00-MNhIyYEChGthl2p70BpVqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 10, 2003 at 10:51:53PM +0000, Luís Miguel Pires Neves wrote:
> Hi!
> 
> This is just a request (desire).
> 
> As S1 is not completely working (backlight, disks spinning...), I wonder if 
> one couldn't find a temporary solution similar to S4bios for machines that 
> have S1 in bios.

S4Bios was easy.  It is documented in specs.  An equivalent to S1 (or S3 btw)
would require hackeries (something like call bios to switch to legacy mode,
then call apm suspend, then recall bios to switch to acpi mode).

I don't have a platform that have correct apm support, and I can only provide 
untested patch in that area.  Worst, I think that S1 is not the real problem
actually, but more a driver problem (especially with 2.4 series).
And controlling the backlight for example is somehow hard to achieve
in a generic way (I will be happy if someone can provide me interresting
info btw).


> I apologise if what I'm saying is stupid as I'm not a developper, just a 
> ordinary Linux user who has been following the development of ACPI and swsusp 
> in order to have it's Laptop with the usual functionality of laptops..
> 
> In my first times with Linux in this machine (COMPAQ Presario 12XL515) I 
> used APM with kernel 2.2.17 (Debian Potato's version) and I had "S1" 
> behaviour with apm -S. At the time it was the single working function as the 
> battery status/information wasn't there, and "S4" seemed also to be absent ( 
> I know now that it was there but it needed a proper configured partition). 
> However with more recent kernels, both 2.2 and 2.4  (not patched with Debian 
> patches) I never had the APM sleeping function working again.

If you can not use anymore APM with 2.4 even with the working apm -S
for the debian's 2.2.17, then there is a generic problem here (regression).
I have not tryied this version of kernel.  Perhaps the only
difference is that it worked for you because most of the drivers
with the 2.2.17 was shipped as modules?

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
