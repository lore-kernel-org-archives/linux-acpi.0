From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 20:22:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020730182219.13608@192.168.4.1>
References: <20020730184442.GE7567@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730184442.GE7567-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>1) implies that new requests are not coming, so driver authors do not
>have to do if (suspended) sleep() in their hot paths.

What about, let's say, an USB device driver that needs the USB host
chip (and thus the whole USB subsystem) to be still alive to send
proper commands to the device for suspend ? (typically setup the
remote wakeup when supported, etc...)

There can be even more nasty dependencies when you start stacking
things.

There are ordering dependencies. Those dependencies are dictated
by the bus layout that is fortunately provided for us by the new
driver model (let's not mix it with driverfs). It's not a subsystem
that has to be suspended not to send requests to a driver, it's
a driver that has to stop accepting requests, though it's then
perfectly valid for the subsystem to provide a "helper" routine
for the driver to deal with that.
(Typically, those "helpers" already exist for other purposes anyway
like stopping your block queue, stopping your network queue, etc...)

Ben.




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
