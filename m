From: Jean-Pierre Schwickerath <lists-Z7rXY4Hz9HLk1uMJSBkQmQ@public.gmane.org>
Subject: Re: ACPI client
Date: Fri, 31 Jan 2003 12:47:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030131124705.2dee14c2.lists@schwicky.net>
References: <3E3A47C4.20807@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E3A47C4.20807-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

siva <sivakumar.subramani-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org> wrote:

> Hi,
> 
> Where can I get the ACPI client rpm / source tar file?
> 
> In the sourceforge.net, I can find only the acpid daemon source. While
> 
> reading the HOWTO document, it has been mentioned that it will be part
> 
> of acpid source.
> Can any one please send me the link to download the acpi client?

Client? 
acpid ist the "client". It listens on the event "socket" in the
/proc/acpi directory and acts uppon this. 

If you look for the kernel patches to support ACPI, have a look at

http://sourceforge.net/project/showfiles.php?group_id=36832



Jean-Pierre

-- 
Powered by Linux From Scratch - http://schwicky.net/
PGP Key ID: 0xEE6F49B4 - AIM/Jabber: Schwicky - ICQ: 4690141

Nothing is impossible... Everything is relative!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
