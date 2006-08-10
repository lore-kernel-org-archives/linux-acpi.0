From: "Daniel Smertnig" <daniel.smertnig@gmail.com>
Subject: Re: C4 state missing on T60p (Intel Core Duo)
Date: Thu, 10 Aug 2006 08:22:08 +0200
Message-ID: <18dd01ff0608092322k6b08a736kf1f85b0b4da53f78@mail.gmail.com>
References: <CFF307C98FEABE47A452B27C06B85BB60133D600@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:57947 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161076AbWHJGWJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Aug 2006 02:22:09 -0400
Received: by ug-out-1314.google.com with SMTP id m3so373447ugc
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2006 23:22:08 -0700 (PDT)
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB60133D600@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On 8/10/06, Brown, Len <len.brown@intel.com> wrote:
> On AC/DC events, _CST is re-evaluated and the BIOS
> gives the OS a different answer.  We don't print out the
> IO address used to enter the state, but if we did,
> you'd find that it changes along with the reported latency.

Thank you very much for your fast answer, I didn't notice this..
that's indeed the case :-).


> The reason you are not entering  OS C3 when on DC is because
> of bus master activity.

Actually it usually does enter C3(C4) when on battery, it's just that
I printed the data immediately after unplugged, but thanks for the
tip.

Bye,
Daniel
