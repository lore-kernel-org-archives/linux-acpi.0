From: Andi Kleen <ak@linux.intel.com>
Subject: Re: next-0702: ACPI Error (nseval-0159): Insufficient arguments
Date: Thu, 03 Jul 2008 15:48:51 +0200
Message-ID: <486CD8C3.7030007@linux.intel.com>
References: <a4423d670807030607s28bc7205l3bf46b49cff4176d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <a4423d670807030607s28bc7205l3bf46b49cff4176d@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, akpm@osdl.org
List-Id: linux-acpi@vger.kernel.org

Alexander Beregalov wrote:
> Hi
> 
> I have several these messages.
> It is Dual-Core Opteron 1214.
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_DOCK=y
> CONFIG_ACPI_BLACKLIST_YEAR=0
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_PNPACPI=y
> 
> Let me know if you need more info.
> 
> [    0.888708] WARNING: at nseval:159 acpi_ut_error+0x32/0xa2()

Andrew, that's the bad side effect I talked about earlier. Now the
warning doesn't report the right place, but just the error function
and it's unclear who causes it due to the unreliable backtrace.

Alexander,

Is this something that you didn't see in older kernels? If yes when did 
it start?

Can you please file a full report in http://bugzilla.kernel.org?

Thanks,
-Andi
