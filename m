From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Acer Travelmate 4000LCi - Newbie
Date: Fri, 03 Jun 2005 10:34:21 +0200
Message-ID: <42A0160D.50909@gmx.net>
References: <650b40eb05060215494772060c@mail.gmail.com> <m28y1rj36s.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m28y1rj36s.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Bo Harron <bharron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Johan Vromans schrieb:
> Hi Bo,
> 
> If Suse provides for DSDT overriding upon boot (I've heard some
> rumours on that, but I'm not familiar with Suse) _AND_ someone can

Yes, that function is indeed shipped by SUSE. IIRC the handbook
mentions how to do it.

> provide an augmented DSDT for your particular notebook, it would be as
> easy as installing a file and rebooting. But that would require

It's a bit different: Copy new DSDT to a specific location, set
ACPI_DSDT="location_of_DSDT" in /etc/sysconfig/kernel, run mkinitrd
and reboot.

> assistance of another Travelmate 4000LCi user.
> 
> Otherwise, my suggestion would be to consult the Suse mailing lists on
> how to re-create your current (installed) kernel. When you are able to
> do that, I'd advise to take Rich Townsends sbs module that implements
> the classical battery status API.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
