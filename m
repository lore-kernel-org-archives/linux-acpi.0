From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC 2/2] new C-state policy
Date: Wed, 11 Jan 2006 12:22:05 +0100
Message-ID: <43C4EA5D.9040907@suse.de>
References: <1136866376.5750.29.camel@sli10-desk.sh.intel.com> <20060110231711.GB30356@isilmar.linta.de> <1136944855.5750.61.camel@sli10-desk.sh.intel.com> <20060111080402.GB599@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060111080402.GB599-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI-ML <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pallipadi Venkatesh <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
> 
>>> Also, the actual checking for bm_activity should be common code, e.g.
>> It's policy specific. Each policy could have its own method to calculate
>> bm_activity.
> 
> What to do once bm_activity is or was detected, yes. How to determine
> whether there is current bus mastering activity, no -- that's core stuff,
> not policy stuff.
> 
I had the experience that tweaking how bm_activity is detected could help a lot.
An aggressive policy might also accept some faulty transitions in respect of more
power saving achievements.
What about the way in the middle?:
A general check_bm_activity() function. This one can be overridden by more
complex policy drivers/modules.

I hope to get some time the next days to play with all this...

  Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
