From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [AML] _OSI
Date: Fri, 30 May 2003 09:59:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030530075921.GC346@poupinou.org>
References: <3ED691B2.8020609@odi.ch> <3ED69AF7.8020103@odi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ED69AF7.8020103-L693kI9kcNY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ortwin =?iso-8859-1?Q?Gl=FCck?= <odi-L693kI9kcNY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 30, 2003 at 01:42:47AM +0200, Ortwin Glück wrote:
> Okay, I just included some Debug statement into my DSDT.
> Findings:
> 
> _OSI is not supported.
> 
> \_OS_ equals "Linux"
> 
> Follows:
> Some sections in my DSDT (see attachment) are not executed on Linux.
> 
> This is the (decompiled and fixed) DSDT of an Acer TM630.
> 
> Isn't it a strange world where the BIOS is specific to an OS? And I
> thought the OS should adapt to the hardware and not vice versa...
> 

This _OS stuff is pure crasp IMHO.  The _OSI method is a Microsoft
extension, and is documented somewhere in their site.  As for
_OS, that is only crasp.

Note that you can pass the acpi_os_name='' if you want
to change _OS so that some method may work 'better' for you.
Sometimes, it may help to try others values, but YMMV.


Note also that only some thinkpads have _OS == 'Linux' related
stuff implemented in their DSDT, but it seems that it is not
well used though (at least, IBM do care of that, even
if it is not perfect).
I don't find that others vendors do care of others OS other
than redmond' one.  But it is for laptops/desktop word.

To be fair, _OS seems not to be used in servers.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
