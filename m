From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI, APEI, Add APEI _OSC support
Date: Tue, 14 Jun 2011 14:33:19 +0800
Message-ID: <4DF700AF.3090702@linux.intel.com>
References: <1306303538-30524-1-git-send-email-ying.huang@intel.com> <20110613145012.GA1924@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43283 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab1FNGdW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jun 2011 02:33:22 -0400
In-Reply-To: <20110613145012.GA1924@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

=E4=BA=8E 6/13/2011 10:50 PM, Don Zickus =E5=86=99=E9=81=93:
> On Wed, May 25, 2011 at 02:05:38PM +0800, Huang Ying wrote:
>> In APEI firmware first mode, hardware error is reported by hardware =
to
>> firmware firstly, then firmware reports the error to Linux in a GHES
>> error record via POLL/SCI/IRQ/NMI etc.
>>
>> This may result in some issues if OS has no full APEI support.  So
>> some firmware implementation will work in a back-compatible mode by
>> default.  Where firmware will only notify OS in old-fashion, without
>> GHES record.  For example, for a fatal hardware error, only NMI is
>> signaled, no GHES record.
>>
>> To gain full APEI power on these machines, a special APEI _OSC needs
>> to be evaluated to tell firmware that Linux has full APEI support.
>> This patch add the APEI _OSC support.
>
> Using an Intel box I have over at RedHat, I was able to use this patc=
h to
> get error injection (EINJ) to provide me a GHES record.  Prior to thi=
s
> patch I would just get unknown NMIs.
>
> Talking with Matthew Garret, I guess it seems that uuids like this ar=
e
> typical for ACPI.
>
> I can't speak for all the ACPI parts, but the patch looks simple and
> corret from my perspective.
>
Interesting, but I can't reproduce it on our machines by now. Would you
please share your test information such as machine type, BIOS
version, and test method (such as what type error you inject) ?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
