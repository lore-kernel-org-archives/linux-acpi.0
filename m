From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] acpi/processor: fix for !CONFIG_CPU_IDLE
Date: Tue, 29 Jun 2010 07:45:28 +0100
Message-ID: <4C29B2A80200007800008850@vpn.id2.novell.com>
References: <4C238A8902000078000080B1@vpn.id2.novell.com>
 <alpine.LFD.2.00.1006281440430.16755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006281440430.16755@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

>>> On 28.06.10 at 20:42, Len Brown <lenb@kernel.org> wrote:
> On Thu, 24 Jun 2010, Jan Beulich wrote:
> 
>> The conditional modified (to have an 'else' portion) in commit
>> 2671717265ae6e720a9ba5f13fbec3a718983b65 degenerates to an
>> unconditional NULL dereference when CONFIG_CPU_IDLE is off, as
>> cpuidle_register_driver() returns non-zero in this case, and
>> cpu_idle_get_driver() returns NULL. The simplest solution is to make
>> the whole construct depend on CONFIG_CPU_IDLE bein defined.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> 
> As CONFIG_ACPI selects CONFIG_CPU_IDLE,
> how were you able to provoke this issue?

Oh, indeed, I forgot that it's a specific of our kernels that the select
is a conditional one. Sorry for the noise then.

Jan

