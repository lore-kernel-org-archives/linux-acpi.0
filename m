From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 27/30] ACPI: EC: Add a quirk for CLEVO M720T/M730T
 laptop
Date: Tue, 9 Oct 2012 14:22:06 +0800
Message-ID: <20121009142206.63dd9981@feng-i7>
References: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
	<67bfa9b60bd689601554526d144b21d529f78a09.1349761836.git.len.brown@intel.com>
	<20121009061633.GA3648@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121009061633.GA3648@elie.Belkin>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Jonathan,

On Tue, 9 Oct 2012 14:16:33 +0800
Jonathan Nieder <jrnieder@gmail.com> wrote:

> Len Brown wrote:
> 
> > By enlarging the GPE storm threshold back to 20, that laptop's
> > EC works fine with interrupt mode instead of polling mode.
> 
> What would go wrong if the threshold were just increased to 20 on all
> models?

Then some other platform will stop to work.
	https://bugzilla.kernel.org/show_bug.cgi?id=11892 

The 26/30 and 27/30 patches are bound together to fix one bug. Some
quote from description from the 26th patch:

ACPI_EC_STORM_THRESHOLD was initially 20 when it's created, and
was changed to 8 in 2.6.28 commit 06cf7d3c7 "ACPI: EC: lower interrupt storm
threshold" to fix kernel bug 11892 by forcing the laptop in that bug to
work in polling mode.

Hope this answers your question.

Thanks,
Feng
