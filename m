From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ERROR - Could not suspend device 0000:00:1d.7: error -5
Date: Tue, 8 Mar 2005 12:07:43 +0100
Message-ID: <20050308110742.GC23640@elf.ucw.cz>
References: <9ed79ee0050306042055f815bb@mail.gmail.com> <200503061625.25161.destynova@esatclear.ie> <9ed79ee00503061436228f66c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed79ee00503061436228f66c2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Po 07-03-05 09:36:15, boltmelots wrote:
> Hi:
> Thank you very much for your reply.
> As you said I removed ehci_hcd and uhci_hcd from the running modules and tried, 
> 'echo standby > /sys/power/state' : This I assume worked because all i
> see on the screen is:
> Stopping tasks:
> ==================================================================================|
> But trying to resume the thing is a problem, it produces a bunch of
> errors that i have no idea what it means.  I have to manually reboot
> the computer, because it freezes.  How can I extract the errors?  I
> think I will write them down on paper :-S
> 
> I also tried 'echo mem > /sys/power/state', and that works too.  But
> on resume the screen is blank.  No idea what is happening!

Read Doc*/power/video.txt. Also try to get swsusp working, first.

Ugh, I'd suggest using your real name in From: header, no m$
references and less !s if you want to get answers in future.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
