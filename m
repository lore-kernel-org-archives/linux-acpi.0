From: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Subject: Re: CONFIG_DEBUG_SLAB=y prevents kernel panic
Date: Sat, 06 Dec 2003 03:05:51 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FD19BEF.2060807@comcast.net>
References: <3FD0F0DE.4050708@comcast.net> <1070673944.30487.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1070673944.30487.17.camel-Z+iYsftfazAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2003-12-05 at 20:55, Ian Pilcher wrote:
> 
>>The question is, where do I go from here?  The help for
>>CONFIG_DEBUG_SLAB makes it seem unlikely that this is the root cause,
>>but I don't have any idea how I can debug this further.
> 
> 
> If that is really what makes the difference then 99 times out of 100 you
> are looking for code that kmallocs memory and then relies on its content
> without clearing it.
> 
> 

Setting CONFIG_DEBUG_SLAB is definitely the deciding factor.  (I editted
the i686-smp config file and rebuilt the SRPM; voila!, it boots with
ACPI turned on.)

Any suggestions on how I can find the offending code?

-- 
========================================================================
Ian Pilcher                                        i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org
========================================================================




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
