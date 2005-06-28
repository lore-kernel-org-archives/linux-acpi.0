From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: Re: Suspend to RAM works, but no wake up. ATI Technologies
 Inc Rage Mobility P/M (rev 64) video card
Date: Tue, 28 Jun 2005 17:35:30 +0200
Message-ID: <20050628173530.048fb71a.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi

Here is another set of mails, that I sent to the XFree86 mail list, and
this gentleman below advised me to something, that didnt work
unfortunately, but while trying, I realized another thing. It is at the
bottom of this email.

Thanks

Ben

> On Sun, 26 Jun 2005, Benedek Frank wrote:
> 
> > My Sony Vaio laptop has a strange problem. It has the ATI
> > Technologies Inc Rage Mobility P/M (rev 64) video card, and first of
> > all X was really hard to make work. Only the latest 4.5 works fine
> > with this, and some old ones, like 4.0 or 4.2. My disribution was
> > Sarge Debian, and it has 4.3 by default. That doesnt work at all at
> > 1024x480 resolution. It was all greyish even with the right
> > modeline. ANyways, 4.5 works fine for
> 
> Yes.  Only in 4.5 does the driver correctly grok the mode on server
> entry for  all currently known cases.
> 
> > me. What is the problem, that when I go to suspend with ACPI
> > (S3-RAM), the display wont power off completely, just it gets
> > dimmed, but some text remains on the LCD. For the "untrained" eyes,
> > it seems off, but when I tilt the LCD, I can see it is on and has
> > text on it. Also, it is making a buzzing sound, so it eats battery.
> 
> > What can I do to turn off the display? Maybe I can inegrate the
> > solution to my suspend script, so that it turns the LCD off and then
> > suspends.
> 
> The server currently does not have any ACPI framework.  Assuming
> you're  running Linux, you'll probably need to configure acpid to
> issue `chvt 1` on  S3 events (perhaps S1 & S2 also), and `chvt 7` (or
> whatever) on return to S0.
> 
> A possible alternative is to switch use APM instead, but that's being 
> deprecated.
> 
> Marc.
> 
Hello

Thanks for the help. Unfortunately I dont want to go to use APM as that
is depreciated as you said. 

What you said about the chvt, I was really happy to hear, and I tried,
but it does not work unfortunately. Same as before, buzzing sound and
the display shows writing. (UPDATE: not only writing, but also vertical
lines, about 50 of them, right next to eachother, and horizontal lines,
about 3-4 of them far apart.) But this writing is very hard to see. Not
obvious at all. I realized it after 2 months of using it, so you can see
how dimmed it is. Also, another very interesting thing, that when I open
the lid, and the laptop is still asleep (it needs button press to wake),
as I said, I can see the writing from an angle, but only if I turn the
LCD to the left, or right, and get some sunshine on it, or light. Now,
when I press the button (space usually), it starts to wake up, and the
first moment when I press the button, I think the LCD goes off for a
moment only, and then wakes up. Why I think this? I checked carefuly,
and before I press the space bar, the text is on the display, and when I
press the SPACE bar, it gets erased, and the screen is even darker, but
only for a second or less, and then backlight comes back on.


Another thing to note, is that the text I see on the display looks
something like this:

******************IRQ Something************
*************Stopping tasks................

SOmething like that. And again, when I press the space bar, it goes
away, and finally the screen looks to be off for a moment.

Thanks

Ben


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
