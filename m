From: Laszlo 'GCS' Boszormenyi <gcs-gKC9iF2I70U@public.gmane.org>
Subject: Re: gericom notebook reboots instead of poweroff
Date: Wed, 3 Nov 2004 08:18:33 +0100
Message-ID: <20041103071833.GA12510@pooh>
References: <20041026194029.GA10954@pooh> <20041102203243.GA996@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041102203243.GA996-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

* Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> [2004-11-02 21:32:43 +0100]:

> >  I have tried to look into existing bugreports, but could not find any
> > similar to this on the Kernel Bugzilla nor in the ACPI Bugzilla. All I
> 
> Eh? Something very similar happens on acers and evos and probably
> more.... See mail archives.
 No offence taken; I was looking into the Bugzilla, as well to the mail
archives. Could not find anything relevant that time. But as I have
reported this, other people showed up, and followed on my bugreport here
on this mailing list and on the kernel bugzilla, as well you opened up SuSE
bugzilla later on. I think you missed my _original_ mail.
 Anyway it is a bit bad that developers haven't show up. As noted, I
could sharpen the location of this bug to 2.6.8.1 and the later added
2.6.9-bk1; still could not find out how to get -bk1 into changeset pieces
and apply those step by step while recompiling the kernel, reboot and
see in which changeset this bug was introduced. Blame me, this is all
what I can offer to help fixing this.
I would greatly appreciate any help how to handle BitKeeper to get those
changesets individualy.

Kind regards,
Laszlo



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
