From: "Wiesner Thomas" <w15mail-LWAfsSFWpa4@public.gmane.org>
Subject: BAT1/state shows wrong capacity and THRM/temperature is wrong too
Date: Mon, 21 Feb 2005 13:04:00 +0100
Message-ID: <opsmjqgyt8wxmtbz@barton2>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello

I have a strange ACPI proglem.
I own a Gericom SilverSeraph laptop on which I run a self-modified
Debian 3.0 and kernel 2.6.10.

When I do a
	cat /proc/acpi/battery/BAT1/state
I always get a battery state of 51% (if you calculate it).
After cat'ing the file 4 times, the values is correct on from the
5th cat.

Even stranger, a
	cat /proc/acpi/thermal_zone/THRM/temperature
after a reboot tells me a temperature of 45 C. It always says
45 C. But if I cat the battery state 5 times of more (which makes
the battery output correct), the temperature value is correct too.


The problem shows up in WinXP (I use a dual boot config) too.
If i open the battery-dialog immediately after bootup, I can see the
status bar showing a capacity of 51%. The difference to Linux is, that
Win seems to query the battery status in regular time intervals which
causes the battery status to show correct values after a few seconds.
I don't know how to verify the temp-problem in Win.

I should mention, that early 2.6 kernels didn't show this
"cat me five time" beahviour, I don't know why. I should mention too
that some 2.6 kernel version warned me about a buggy ACPI implemention
(... please nag you manufacturer to correct it ...; I don't
remember accurately) which seems to have gone away with later
kernels (Don't ask with which, I can't remember.).


Because of this facts I think it might be a hardware/ACPI implemention
problem.


		Should it be blacklisted?

		Should a workaround be made (query the batt stat some times
		kernel-internally on bootup)?


If you need more information, please let me know.

Hope this helps you (and maybe me).

BTW: Please CC me, as I'm not in the list.


        Wiesner


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
