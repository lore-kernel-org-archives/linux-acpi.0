From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Wed, 5 Jan 2005 19:14:41 +0100
Message-ID: <20050105181441.GA1157@openzaurus.ucw.cz>
References: <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org> <41D98251.9020002@arrakis.dhis.org> <20050103180219.GX19199@poupinou.org> <41D9A1F5.1060508@arrakis.dhis.org> <20050104100844.GA19199@poupinou.org> <41DAA92C.4080605@tiscali.be> <47e0449d05010406454e59b16a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <47e0449d05010406454e59b16a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hia

> I'm trying this out on an Acer Travelmate 4001LCi. With the version of
> today, I get nice results for the battery, though I experienced the
> same you did. But as fas as I could see this behaviour only takes
> place, if I run smartbattery repeatedly with a very short delay. If I
> only run it from time to time, it seems to be decreasing normally.

I'd say increases are ok. Imagine period of high cpu load
(machine takes 50W and thinks "if it goes like that, I can only
last 15 minutes"),
then cpu goes idle (25W, "okay, I can survive 30 minutes with load
like this").

At this point, available time *should* go up.


-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
