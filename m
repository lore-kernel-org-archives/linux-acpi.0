From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:18:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730181810.30687@192.168.4.1>
References: <20020730182921.GD7567@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730182921.GD7567-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>Why? You should modify network stack not to post any packets to them.

No, you should have the _driver_ ask the network stack not to get
packets on _this_ specific interface.

>>  - Block drivers just need to stop their queue
>
>Block layer should not attempt to pass anything to driver when
>suspended. (Theres one block layer, but 100 block drivers; which one
>would you like to modify?)

Again, it's a specific driver that has to inform the block layer.

Suspend hierarchy isn't per-subsystem. You may well need a given
subsystem to be alive for a separate driver to suspend itself
properly. It has to be bus-driven.

However, the bus-binding of a driver is completely orthogonal
to the subsystems to which that driver is attached (and gets
requests from).

>[Currently I'm stopping it at even higher level by stopping
>processes. I still think stopping everything is easiest solution, and
>probably only one doable for 2.6.]

Well, it could be done stopping process first, until all drivers are
safe enouh. That mean keeping the IO blocking semantics for drivers
while having the process stopped to help deal with drivers not
implementing that at first, but I'd prefer doing it the right way
first.

>>  - Things like serial drivers usually don't have to do anything
>>    terrific, just stop the chip interrupt and users will be blocked
>>    (or will timeout, but that is not a problem at this point)
>>  - For pmac sound driver, I choose to have a mutex that cause users
>>    to be blocked, but that was the "easy" way to quickly get that
>>    done, a more subtle mecanism could be done, dropping samples at
>>    approximately the output rate. The mutex makes it easy to make
>>    the whole driver SMP safe as well regarding mixer tweaks though.
>
>Why don't you just put that mutex into sys_read etc? Or why not system
>stopping? There's just too much drivers.

sys_read, sys_ioctl, etc... ? well, drivers can be kicked by other
means than just syscalls. And if you tear down subsystems, you take
the risk of stopping a subsystem before a driver that need it for
proper suspend had a chance to use it.

>Kernel tells them that console is being switched away; so it is their
>responsibility. Surprise, special console for suspend is not only
>pretty but also usefull ;-).

Yes, in this specific case, I agree, it's much better than make faked
fbcon ops I use in fbdev drivers ;)

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
