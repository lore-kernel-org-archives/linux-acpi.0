From: Jon Valvatne <jon-hc6/xhmWZxdWk0Htik3J/w@public.gmane.org>
Subject: Suspend-to-RAM on Sony Vaios
Date: Mon, 18 Oct 2004 02:08:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041018020816.48673359@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello list,

I'd very much like to get suspend-to-RAM working on my Vaio X505; any pointers would be very welcome. Trying with the latest RPM-kernel for FC2, I can get it suspended just fine (after removing the ehci_hcd module), but it doesn't come back up.

Specifically: Once it's suspended, it seems dead except for a slowly blinking red power LED. When I press any button or key, it goes completely dead, requiring the battery to be taken out and reinserted before it'll even respond to the power button. Between those two states (blinking LED and completely dead) there is no indication whatsoever that it even tries to wake up - the LED simply stops blinking the moment I touch a key.

I haven't heard of anyone else installing Linux on this specific model of Vaio yet, and all I see of other Linux-on-Vaio-experiences only tell of similar problems, with no solutions. All the suspends-but-doesn't-resume stories I've seen here on this list tell of systems that make signs of starting up before they crash, as opposed to mine which doesn't. That makes me think my case is different, and it makes me doubt that it's the VGA issue again... I could be wrong though, I don't pretend to know the details of this stuff.

Any pointers on how to debug this problem at all? The syslog is obviously useless; the hard drive isn't even spinning when the problem occurs.

Thanks in advance,

Jon Valvatne
Barcelona, Spain


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
