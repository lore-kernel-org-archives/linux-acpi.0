From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is: axe read_tscp pvops call. Was: Re: [RFC] ACPI S3 and Xen
 (suprisingly small\!).
Date: Wed, 17 Oct 2012 09:50:11 -0700
Message-ID: <507EE1C3.7070300@zytor.com>
References: <1350481786-4969-1-git-send-email-konrad.wilk@oracle.com> <507ED6C0.4020503@zytor.com> <20121017161036.GA10691@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121017161036.GA10691@phenom.dumpdata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, lenb@kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 10/17/2012 09:10 AM, Konrad Rzeszutek Wilk wrote:
> On Wed, Oct 17, 2012 at 09:03:12AM -0700, H. Peter Anvin wrote:
>> On 10/17/2012 06:49 AM, Konrad Rzeszutek Wilk wrote:
>>>
>>> Note: These are the other patches that went in 3.7-rc1:
>>> xen/bootup: allow {read|write}_cr8 pvops call [https://lkml.org/lkml/2012/10/10/339]
>>> xen/bootup: allow read_tscp call for Xen PV guests. [https://lkml.org/lkml/2012/10/10/340]
>>>
>>
>> So WTF do we have a read_tscp PV call?  Again, if there isn't a user
>> we should just axe it...
>
> Let me spin off a patch to see if that can be done.
>

Could you do an audit for other pvops calls that have no users?  If the 
*only* user is lguest, we should talk about it, too...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
