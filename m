From: Jean-Pierre Schwickerath <lists-Z7rXY4Hz9HLk1uMJSBkQmQ@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Sat, 8 Feb 2003 17:19:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030208171937.325d6749.lists@schwicky.net>
References: <026401c2cf88$9b26d330$0a0110ac@erik>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <026401c2cf88$9b26d330$0a0110ac-QyX2VyNvpUU@public.gmane.org>
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

"Erik van Pienbroek" <admin-0LxUhLuGNoZIf6P1QZMOBw@public.gmane.org> wrote:

> The /proc/acpi/sleep same story..if I echo '4' in it the notebook
> would continue to work..if I echo '3' the
> notebook would hang...with echo '5' the notebook would also hang...
> Is this because the ACPI support isn't complete yet or am I doing
> something wrong ?


With ACPI the control of Power Management is given into the hands of
the OS. It means you can suspend machines which have a BIOS that doesn't
support suspend to disk or suspend to ram as the OS emulates the
process. 
This could be the case with your notebook. 

I have a hp omnibook xe4400 and a similar behaviour. I didn't manage to
find out if my machine has the ability to suspend to disk from bios yet.

Anyway, swsusp (software suspend) works like a charm. 
Have a look at http://sourceforge.net/projects/swsusp for the kernel
patches and the scripts to suspend your notebook. 


Jean-Pierre

-- 
Powered by Linux From Scratch - http://schwicky.net/
PGP Key ID: 0xEE6F49B4 - AIM/Jabber: Schwicky - ICQ: 4690141

Nothing is impossible... Everything is relative!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
