From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [RFC PATCH 2/3] x86, MCE: Avoid potential deadlock in MCE context
Date: Tue, 22 Jul 2014 14:24:06 -0700
Message-ID: <CA+8MBbJ3BLXwquF6kktmUOWdXRt_=yQha2GL5R8zFVzLo4O-gg@mail.gmail.com>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
	<1405478082-30757-3-git-send-email-gong.chen@linux.intel.com>
	<20140721084737.GA10016@pd.tnic>
	<3908561D78D1C84285E8C5FCA982C28F32870C55@ORSMSX114.amr.corp.intel.com>
	<20140721214116.GC11555@pd.tnic>
	<3908561D78D1C84285E8C5FCA982C28F32871435@ORSMSX114.amr.corp.intel.com>
	<20140722172609.GI6462@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140722172609.GI6462@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Chen, Gong" <gong.chen@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 22, 2014 at 10:26 AM, Borislav Petkov <bp@alien8.de> wrote:
> Once they've been eaten by something, we simply remove them from that
> buffer and that's it.

swap that for

Once everyone who registered a notifier as had a chance to see each
logged entry, we simply remove ...

I'm not a fan of the current NOTIFY_STOP behavior where one registrant
can say they are so important that nobody else should be allowed to see
what was logged.

-Tony

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
