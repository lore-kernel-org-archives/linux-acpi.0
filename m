From: Pavel Machek <pavel-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Subject: Re: ACPI Suspend Standby Sleep
Date: Thu, 1 Aug 2002 11:48:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020801094815.GA159@elf.ucw.cz>
References: <20020730075329.26474@192.168.4.1> <000001c23813$a8888ad0$9865fea9@AMAINSLT>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000001c23813$a8888ad0$9865fea9-9tCyY70DaME@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "A.MAINS" <armains-ZO4F0KnmCDHk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!
> 
> I just informed the list on how I finally got my Battery Information
> working on my Presario. (Thank you everyone) I also mentioned I was
> about to take the next endeavor into Standby / Suspend. 
> 
> I loaded ACPID. I also know there is a Kernel patch for software suspend
> (swusp). However, I am wondering if there are any success stories using
> the ACPI Daemon / Kernel for sleep.
> 
> If so, what do I have to do to utilize this feature?

You get 2.5.29, then echo 4 > /proc/acpi/sleep. Read Docs/swsusp.txt.
								Pavel
-- 
I'm pavel-7aPAsKgELzg@public.gmane.org "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss-q33YXrgyAoMgsBAKwltoeQ@public.gmane.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
