From: dom <dom.domino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: omnibook xe3gc, kernel 2.6.9, acpi and volume keys
Date: Mon, 22 Nov 2004 19:30:54 +0100
Message-ID: <81baca8504112210307f4d97f1@mail.gmail.com>
Reply-To: dom <dom.domino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Here is a copy of a message sent to the forum of the omnibook module


-- Hi all, 
after years using mandrake i decided to switch to gentoo. 
 
I am currently using kernel 2.6.9 
I succeded in installing omnibook module version 2004-09-16.
Multimedia keys (www, mail, demo, help, previous track, next track,
play, stop) are working fine.
The problem comes for volume keys. I used key_polling with my previous
system and it works fine. But now, /proc/omnibook/key_polling doesn't
exist. So i read t
he doc, and tried acpid version 1.0.4 . I got event for the sleep
button but nothing for the volume button. Am i missing something ?
-------------------------------------------------------------

Someone point out that it may be acpi things related

Previously, i was using a mandrake 9.2 with an old version of the omnibook
module which was providing key_polling useful for the 2 volume keys in front 
of my laptop. Now, i am able to use all the multimedia buttons, except
those two.
I read somewhere in the omnibook module doc that the sleep button and the 
volume buttons should be detected by acpi.
I am using a kernel 2.6.9 (gentoo-dev-source) with acpi version
20040816 and acpid version 1.0.4.
When i press the sleep button i get this output in /var/log/acpi :
[Mon Nov 22 19:18:27 2004] received event "button/sleep SBTN 00000080 00000002"
[Mon Nov 22 19:18:27 2004] executing action "/etc/acpi/default.sh
button/sleep SBTN 00000080 00000002"
[Mon Nov 22 19:18:27 2004] BEGIN HANDLER MESSAGES
[Mon Nov 22 19:18:27 2004] END HANDLER MESSAGES
[Mon Nov 22 19:18:27 2004] action exited with status 0
[Mon Nov 22 19:18:27 2004] completed event "button/sleep SBTN 00000080 00000002"

But when i press the volume buttons, nothing happens in /var/log/acpid
nor xev ...

Am i missing something ? 

-- 
@+
dom


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
