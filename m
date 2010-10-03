From: Tiago Marques <tiagomnm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery
 lifetime on Windows
Date: Sun, 3 Oct 2010 16:01:41 +0100
Message-ID: <AANLkTin5Kjiw+Z4F8Y+h+c0Qb_tu1o0SuwHEJ=R3iu40@mail.gmail.com>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
	<201009020152.37466.trenn@suse.de>
	<AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
	<201009061035.03727.trenn@suse.de> <4C850D10.2050801@linux.intel.com>
	<AANLkTik0oTMzTCyNwS6X-CeQK_cJLs90=eU7o9_Rn1XE@mail.gmail.com>
	<4C85790A.50005@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5821129294689074932=="
Return-path: <discuss-bounces-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org>
In-Reply-To: <4C85790A.50005-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <http://lists.lesswatts.org/options/discuss>,
	<mailto:discuss-request-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lesswatts.org/pipermail/discuss>
List-Post: <mailto:discuss-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org>
List-Help: <mailto:discuss-request-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lesswatts.org/listinfo/discuss>,
	<mailto:discuss-request-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org?subject=subscribe>
Sender: discuss-bounces-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org
Errors-To: discuss-bounces-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org
To: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: discuss-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--===============5821129294689074932==
Content-Type: multipart/alternative; boundary=e0cb4e887547d300200491b7b58b

--e0cb4e887547d300200491b7b58b
Content-Type: text/plain; charset=UTF-8

I see. Thanks. It seems that intel_idle isn't supported on Core 2 based
Celerons.

Best regards

On Tue, Sep 7, 2010 at 12:28 AM, Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>wrote:

>  On 9/6/2010 3:03 PM, Tiago Marques wrote:
>
>> On Mon, Sep 6, 2010 at 4:47 PM, Arjan van de Ven<arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>  wrote:
>>
>>>  On 9/6/2010 1:35 AM, Thomas Renninger wrote:
>>>
>>>> Hi,
>>>>
>>>> I am adding lesswatts.org and linux-pm list.
>>>> I expect you found out why you do not get frequency/P- states and it
>>>> seem to be correct. On these lists, people can help you further
>>>> to find out Linux vs Windows battery drain differences.
>>>>
>>>> If you have the same backlight settings, I expect C-state or graphics
>>>> card must be the reason. There is nothing else than CPU or GPU
>>>> that drains so much energy for being the reason of
>>>> 20% more battery life time.
>>>> Which graphics card and driver do you use (for nvidia/ati, trying the
>>>> binary one for comparison, might show a big difference on a recent
>>>> card)?
>>>> Which C-state driver do you use (there is an acpi and intel_idle one
>>>> with latest kernels):
>>>> cat /sys/devices/system/cpu/cpuidle/current_driver
>>>> I hope to be able to provide a c-state tool soon, for now you have to
>>>> go through:
>>>> cat /sys/devices/system/cpu/cpu*/cpuidle/state*
>>>> to check which and how often/efficient C-states are used.
>>>>
>>> powertop will tell you exactly this
>>>
>>>  Thank you. Please see my previous e-mail. C0, C1 and C4. Do you know
>> of any way to force the intermediate ones for debugging?
>>
>
> intel_idle driver is the only way that's reasonable in amount of work.
>
> for anything else you depend on the grace of the bios.
>
>

--e0cb4e887547d300200491b7b58b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I see. Thanks. It seems that intel_idle isn&#39;t supported on Core 2 based=
 Celerons.<div><br><div>Best regards<br><br><div class=3D"gmail_quote">On T=
ue, Sep 7, 2010 at 12:28 AM, Arjan van de Ven <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" target=3D"_blank">arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</=
a>&gt;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">
<div><div></div><div>=C2=A0On 9/6/2010 3:03 PM, Tiago Marques wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">
On Mon, Sep 6, 2010 at 4:47 PM, Arjan van de Ven&lt;<a href=3D"mailto:arjan=
@linux.intel.com" target=3D"_blank">arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org</a>&gt; =C2=A0wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">
 =C2=A0On 9/6/2010 1:35 AM, Thomas Renninger wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">
Hi,<br>
<br>
I am adding <a href=3D"http://lesswatts.org" target=3D"_blank">lesswatts.or=
g</a> and linux-pm list.<br>
I expect you found out why you do not get frequency/P- states and it<br>
seem to be correct. On these lists, people can help you further<br>
to find out Linux vs Windows battery drain differences.<br>
<br>
If you have the same backlight settings, I expect C-state or graphics<br>
card must be the reason. There is nothing else than CPU or GPU<br>
that drains so much energy for being the reason of<br>
20% more battery life time.<br>
Which graphics card and driver do you use (for nvidia/ati, trying the<br>
binary one for comparison, might show a big difference on a recent<br>
card)?<br>
Which C-state driver do you use (there is an acpi and intel_idle one<br>
with latest kernels):<br>
cat /sys/devices/system/cpu/cpuidle/current_driver<br>
I hope to be able to provide a c-state tool soon, for now you have to<br>
go through:<br>
cat /sys/devices/system/cpu/cpu*/cpuidle/state*<br>
to check which and how often/efficient C-states are used.<br>
</blockquote>
powertop will tell you exactly this<br>
<br>
</blockquote>
Thank you. Please see my previous e-mail. C0, C1 and C4. Do you know<br>
of any way to force the intermediate ones for debugging?<br>
</blockquote>
<br></div></div>
intel_idle driver is the only way that&#39;s reasonable in amount of work.<=
br>
<br>
for anything else you depend on the grace of the bios.<br>
<br>
</blockquote></div><br>
</div></div>

--e0cb4e887547d300200491b7b58b--

--===============5821129294689074932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Discuss mailing list
Discuss-ovCJLiDH4KkgsBAKwltoeQ@public.gmane.org
http://lists.lesswatts.org/listinfo/discuss

--===============5821129294689074932==--
