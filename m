From: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Subject: Re: Network failures with ACPI enabled (kernel 2.4, 2.6)
Date: Tue, 30 Dec 2003 16:57:49 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031230165749.34ed607d.mike@it-loops.com>
References: <20031230010822.155c1466.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031230010822.155c1466.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 30 Dec 2003 01:08:22 +0100
Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org> wrote:

> But then I tried to copy an CD-Image file from our fileserver to my
> notebook. As soon as the transfer started, the following error messages
> appeared
> in my syslog and the transfer stalled. 
> 
> 	b44: eth0: Link is down.
> 	b44: eth0: Link is up at 100 Mbps, full duplex.
> 	b44: eth0: Flow control is on for TX and on for RX.
> 	<repeating>
> 	.........

Today I tried the same transfer with a XIRCOM PCMCIA network card and ACPI enabled.
It worked without a problem.
I am not sure what this means for ACPI <-> B44 though. ;)


/Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
