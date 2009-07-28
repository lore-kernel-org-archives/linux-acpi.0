From: Jens Rosenboom <jens@mcbone.net>
Subject: Re: early_ioremap messages with old ASUS board
Date: Tue, 28 Jul 2009 11:36:48 +0200
Message-ID: <1248773808.6757.4.camel@fnki-nb00130>
References: <1248351634.7237.32.camel@fnki-nb00130>
	 <86802c440907230739ufe30b4cocc4b16faacc009c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752500AbZG1JjJ@vger.kernel.org>
In-Reply-To: <86802c440907230739ufe30b4cocc4b16faacc009c4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2009-07-23 at 07:39 -0700, Yinghai Lu wrote:
> please try attached ...

No more leak messages when booting with this patch.
