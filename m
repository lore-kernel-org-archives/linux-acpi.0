From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: Re: Source of buzzing determined for hp tc1100
Date: Mon, 06 Dec 2004 18:54:35 -0500
Message-ID: <41B4F13B.6060304@joshuawise.com>
References: <41B4E721.1040601@joshuawise.com> <41B4EB17.5010702@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41B4EB17.5010702-Y6VGUYTwhu0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This is a faq, the answer is C3.

Hrm. I looked in the Intel FAQ linked off of the ACPI.sf.net page, and 
didn't find anything there.

I then googled for acpi c3 noise, which gave me some information about 
Thinkpads and sound card noise, but the noise occurs regardless of 
soundcard-osity. In fact, it seems to be coming from near the CPU fan.

I did do a quick test, though. I did a while true; do sleep 1; cat 
/proc/acpi/processor/CPU0/power; done .

While the system is connected to the USB keyboard, the it will never go 
into C3 state, and bus master activity is always ffffffff.

When the system is disconnected, it will stay in C3 state most of the time.

However, when I connect AC power, the buzzing goes away, but the system 
still spends most of its time in C3 state.

I'm willing to believe that the battery's power supply in combination 
with some CPU supply element causes buzzing, and that the [more|less] 
filtered DC supply does not cause this buzzing. This begs the question, 
though - is there really a power savings advantage to C3? Am I missing 
out on something when I am not in C3 state? Will the device run 
noticably cooler/have noticably longer battery life when C3 state is 
enabled?

I have also noticed that C1 state is rarely entered on this device - 
only 10 usage units over about two hours of uptime. The machine feels a 
bit latent otherwise... I'm not certain whether this is due to the lack 
of C1 state usage, or whether this should just be attributed to the fact 
that the machine is a bit underpowered.

joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
