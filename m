From: Dan <overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org>
Subject: Re: throttling resets when checking temp?
Date: Sat, 12 Jun 2004 14:27:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1087064841.8271.0.camel@nazgul.overridex.net>
References: <1086855209.25639.4.camel@nazgul.overridex.net>
	 <20040610085658.GA17661@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040610085658.GA17661-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-06-10 at 04:56, Dominik Brodowski wrote:
> On Thu, Jun 10, 2004 at 04:13:29AM -0400, Dan wrote:
> > Hi there, I'm having what seems to be an odd problem to me.  when I
> > change my cpu throttling by running a command like:
> > 
> > echo 3 > /proc/acpi/processor/CPU0/throttling
> 
> That's only a debug interface, please try using
> 
> echo 0:3 > /proc/acpi/processor/CPU0/limit
> 
> instead.
> 
> 	Dominik

Same result

============================
-Dan "OverrideX"-
ICQ: 7171522
AIM: OverrideX
Jabber: OverrideX-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org

Cold, adj.: When the politicians walk around with their hands in their
own pockets.




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
