From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 22:32:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030213213253.GA28780@hell.org.pl>
References: <200302131628.h1DGSID27482@ikffws2.ikff.uni-stuttgart.de> <Pine.LNX.4.33.0302131031290.1133-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302131031290.1133-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Patrick Mochel:
> > > You're absolutely right. But, most people do those things deliberately, 
> > > and know the consequences. 
> > Do you think someone becomes root and does an "echo 5 > /proc/acpi/sleep"
> > by accident? ;-)
> Definitely. By, trying a range of values, they stumble on one that crashes 
> their system. 

Yeah, as if all the values worked smoothly on all systems. Echoing '1' or
'3' hangs my system in most (S1) or all cases (S3). Should they be
excluded also, or left as a config option? Enabled when they finally work
and are tested on all possible systems?

> > > Think about how this thread started: $Random User sees his system doesn't
> > > suspend when writing '4' to that file, so he tries every other value.
> > This is not a random user. This is someone who plays around with his
> > system while testing beta kernel drivers. 
> > The random user at this stage doesn't know about acpi at all. The
> > random user in the future (when acpi comes with Suse or RedHat Linux 
> > out of the box) will only use the GUIs to suspend and such. So there's
> > no problem at all, I think.
> The GUIs should not, and will not, support writing directly to that file. 
> In the perfect, abstract future, we will not even have /proc/acpi/sleep, 
> we will have an abstracted for entering sleep states. 

So, if you plan to change this anyway in the future (of ACPI becoming
mainstream, or being included in distros), what is really the reason of
changing it now, during the development steage?

Again, should I pull the reset button off my chassis just because I can
accidentally push it, have my machine rebooted, and oh my oh my, loose my
data? Is there really anybody who experiments with the sleep states not
having synced, or otherwise "secured" his data or filesystems?

[...]
> As a whole, we do enforce a minimum amount of policy we do not want to 
> lose users data. And that will happen. 
> 
> Let me repeat, and try and get you to listen: 
> 
> You *will* corrupt your data if you do not flush the disk buffers. 
> You *will* corrupt your data if you do not flush the disk buffers. 
> You *will* corrupt your data if you do not flush the disk buffers. 
> 
> That's why it's so slow when you do a normal shutdown. That's why 
> immediately putting the system into S5 is so fast - we don't flush the 
> buffers. 

This is obvious. At least for halfway intelligent users, who know what they
are doing. As Jens said, no random user will ever tamper with /proc, and if
he does, well, it's all his fault anyway.

[...]
> You are right, though, if they start writing random values into /proc, it 
> is their fault. But, the random range of numbers to be written to  
> /proc/acpi/sleep is small, and not that random. The documentation suggests 
> that some values work and others don't. It's human nature to exercise 
> curiosity and experiment with other close values. If they do, which they 
> are so likely to, I do not want to see them cause any harm to themselves. 

So let the documentation suggest explicitly, what exactly echoing 5 to that
file does? Anyway, as I said earlier, chances are that other values
will cause them equal harm. So what? Is that really the single way to harm
the machine, or cause filesystem corruption? I knew a user, who, when told
to copy a file on /dev/hda1, did exactly what he was said, i.e. "cp
filename /dev/hda1"... does this show that copying over a block device
should be disabled? That something is *generally* a bad idea doesn't mean,
it has no use whatsoever. 

Really, on modern desktops possibly data-corrupting reboots (due to a 
faulty X / DRI / whatever driver) are much more frequent to really care for
a poor user that experiments with ACPI not knowing much about it.

> > > For another, as mentioned before, we have safe mechanisms for halting a 
> > > system. See 'man 1 halt'. 
> > You have *no* other mechanism to turn your box off in less than one
> > second.
> Then concentrate on that, and don't encourage dangerous features in the 
> kernel. 

To be frank, there are some features in the kernel, that during the
configuration stage are labeled as ,,DANGEROUS''. For what reasons, do you
think, they still exist?

Regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
