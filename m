From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: S3 won't resume correctly
Date: Wed, 19 Feb 2003 17:25:55 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030219162555.GA16637@hell.org.pl>
References: <20030218224905.GB8829@hell.org.pl> <20030219103234.GE23503@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030219103234.GE23503-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
> > The system suspends correctly (though issuing some warnings about pagebufd
> > not stopping, which as I told is XFS specific), even the power LED blinks
> > accordingly to the manual, indicating S3. However, upon resume neither the
> > display, nor the keyboard works. Appending acpi_sleep=s3_bios fixes the
> > display, but the keyboard still won't respond. I am able to ssh to the box
> > after resume and everything except the keyboard seems to work fine
> > then.
> Well, that's not that bad, all you need is an driver support for
> keyboard to kick it back to live ;-). You might want to setleds +num
> or something like that.

I found out that reloading atkbd.ko remotely over an ssh session returns
the keyboard back to normal. What is left:
o the fan seems to turn like wild after resume (echo 0 >
  /proc/acpi/CFAN/state does nothing) -- no, it isn't due to the
  temperature nor system load
o DMA must bu turned off for S3 resume (strange, it works with S4 in 2.4.x)
o kernel finds crond and acpid disturbing, and refuses to suspend while
  those are running

I might not have time to try and fix it by myself right now, so I'm
basically notifying you about these problems. Thanks for the support,
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
