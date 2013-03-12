From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/14] x86, ACPI, mm: Kill max_low_pfn_mapped
Date: Mon, 11 Mar 2013 18:51:23 -0700
Message-ID: <fd40bbee-66fd-410b-9304-7ab9c9092c15@email.android.com>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org> <1362718720-27048-2-git-send-email-yinghai@kernel.org> <20130308051059.GC14556@mtj.dyndns.org> <CAE9FiQVMjm7P28XLYGQ675we2+dU+H6rJK2eiO+FFeynYefJHA@mail.gmail.com> <CAOS58YOwSjHyFfAfaY_o3YZKhD-p2gc78ZGrc4N5_NCg+ZVu1A@mail.gmail.com> <CAE9FiQVFvg2M5A5Se5pys5yquNSZeOTV=s4YgLwr6QH_6=nY_w@mail.gmail.com> <CAOS58YNy_Rhg8M_7Qbgyutz68Q67i9R00rTuVy6CyZaFV1MSgA@mail.gmail.com> <51398096.1060304@zytor.com> <20130311225048.GA3872@bremse>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48585 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549Ab3CLB4a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Mar 2013 21:56:30 -0400
In-Reply-To: <20130311225048.GA3872@bremse>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jacob Shin <jacob.shin@amd.com>, linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org

The problem is that the code will be broken, and so it makes no sense.  The #if 0 is really confusing.

Daniel Vetter <daniel@ffwll.ch> wrote:

>On Thu, Mar 07, 2013 at 10:09:26PM -0800, H. Peter Anvin wrote:
>> On 03/07/2013 09:28 PM, Tejun Heo wrote:
>> > On Thu, Mar 7, 2013 at 9:27 PM, Yinghai Lu <yinghai@kernel.org>
>wrote:
>> >> They are not using memblock_find_in_range(), so 1ULL<< will not
>help.
>> >>
>> >> Really hope i915 drm guys could clean that hacks.
>> > 
>> > The code isn't being used.  Just leave it alone.  Maybe add a
>comment.
>> >  The change is just making things more confusing.
>> > 
>> 
>> Indeed, but...
>> 
>> Daniel: can you guys clean this up or can we just remove the #if 0
>clause?
>
>I guess we could just put this into a comment explaining where stolen
>memory for the gfx devices is at on gen2. But tbh I don't mind if we
>just
>keep the #if 0 code around. For all newer platforms we can get at that
>offset through mch bar registers, so I don't really care.
>-Daniel

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
