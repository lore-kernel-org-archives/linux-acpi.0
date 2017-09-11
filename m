From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 02/24] v4l: async: Remove re-probing support
Date: Mon, 11 Sep 2017 10:51:25 +0300
Message-ID: <041af454-9aa7-653c-fa40-6f484829d36e@linux.intel.com>
References: <20170908131235.30294-1-sakari.ailus@linux.intel.com>
 <20170908131235.30294-3-sakari.ailus@linux.intel.com>
 <787019fe-7402-7edb-3de6-9a683de78d71@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <787019fe-7402-7edb-3de6-9a683de78d71-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 09/11/17 10:47, Hans Verkuil wrote:
> On 09/08/2017 03:11 PM, Sakari Ailus wrote:
>> Remove V4L2 async re-probing support. The re-probing support has been
>> there to support cases where the sub-devices require resources provided by
>> the main driver's hardware to function, such as clocks.
>>
>> Reprobing has allowed unbinding and again binding the main driver without
>> explicilty unbinding the sub-device drivers. This is certainly not a
>> common need, and the responsibility will be the user's going forward.
>>
>> An alternative could have been to introduce notifier specific locks.
>> Considering the complexity of the re-probing and that it isn't really a
>> solution to a problem but a workaround, remove re-probing instead.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> I Acked the v8 version, but don't see my Ack here. Did you miss it?

I think I sent v9 around the time you sent the ack. :-) It will be in v10.

-- 
Sakari Ailus
sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
