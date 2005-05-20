From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: ASUS M6 has problem with ACPI events being delayed
Date: Fri, 20 May 2005 19:19:41 +0200
Message-ID: <20050520171941.GA9363@message-id.gmane0305.slipkontur.de>
References: <20050520093315.GA5268@message-id.gmane0305.slipkontur.de> <20050520132340.GD5380@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050520132340.GD5380-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 20, 2005 at 03:23:40PM +0200, Jan Kasprzak wrote:
 
> 	I used to have the same problem (Asus M6R), but it disappeared
> after a kernel upgrade/reconfiguration. Unfortunately I cannot tell exactly
> where the problem was. Do you use CONFIG_PREEMPT?

No, i don't. Actually i was pointed to kernel-bugzilla bug #3851 and am
trying the burst-mode EC patch now (it is compiling), so let's see if this
helps.

The really strange thing for me is, that blocking read from /proc/acpi/event
(cat) seems to work fine, but non-blocking (with select / poll) doesn't.

Update: the burst-mode-EC patch helped, everything seems to work fine now.
Now i have to check for bad side-effects :-)
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
