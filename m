From: Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
Date: Fri, 14 Dec 2018 22:27:25 +0100
Message-ID: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214202406.GI11710@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 12/14/18 21:24, Borislav Petkov wrote:
>
> Because apei_resources_fini() happens under the same condition check and
> if arch_apei_filter_addr was false, it should not become true, all of a
> sudden. Or?

Hi Borislav,

please take a look at the stacktrace. For some reason, and only at that 
specific hardware, the condition is false, there but later the indicated 
error exit is taken whose message you can see immediately before the 
stack trace.

So this should documents the one observed case where the NULL deref is 
actually happening.

Of course, it would be possible to develop another solution, but this 
one appears the simplest and safest to me (minimum changes to the logic).

I have tested the patch on that specifc hardware: I have verified that 
the patch does not trigger the NULL deref anymore.

Of course, on any other hardware we have tested, the bug did not trigger 
at all.

If you don't have that specific hardware, you probably cannot easily 
trigger / verify the problem.

If you need access to the specfic hardware, talk to me in a private 
conversation.

Cheers,

Thomas
