From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 0/2] Generic hardware error reporting support
Date: Mon, 22 Nov 2010 18:43:51 -0500
Message-ID: <4CEB0037.3000303@teksavvy.com>
References: <1290154233-28695-1-git-send-email-ying.huang@intel.com>	<AANLkTin_SyFFP_2=pKoS+8+4V1qXVWyrus7BKz8ENVsJ@mail.gmail.com>	<AANLkTincYS7G1yb2ukT67qvpjwQmptXzQZabLQLYrEqn@mail.gmail.com>	<AANLkTi=U7F7MS48dC=GgGqh=cm8YrtVhrm6sDXOma6Fc@mail.gmail.com>	<AANLkTiki3d3Ft3-XJwFg8DUzUYcz3xPoYTzLZokLf+dv@mail.gmail.com>	<AANLkTinAZgHbexU+LTUZHs-+7C0N990=kyuO-USV1Ncp@mail.gmail.com>	<AANLkTinBBELXbUu1O+iSX+1FMXTwa9epwPYmi7EnCP+o@mail.gmail.com>	<AANLkTikZ=TPN4_GXnUasRq-m8uwy6Spdzd=m_fR08Okt@mail.gmail.com>	<AANLkTimvf8t5Rti73kYKV9cG3d7d7Y=OCn57LQNzUuTR@mail.gmail.com> <AANLkTin_-05__F-CMPcOFHceJraJgDN3EGaHe4MT-EyM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin_-05__F-CMPcOFHceJraJgDN3EGaHe4MT-EyM@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

On 10-11-20 08:06 PM, huang ying wrote:
>
> I have no objection to report hardware errors in system logs too. So
> these people can get the information too. I just want to add another
> tool oriented interface too. So that some other users (like cluster
> administrator) can get their work done better too.

So, use the standard interface for the tool:  syslog.

Have this obscure new tool simply parse the log messages,
and the send/save the data whatever way you like.

No new specialized kernel API required.
