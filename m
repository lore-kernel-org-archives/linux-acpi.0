From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] acpi: Add BayTrail SoC GPIO and LPSS ACPI IDs
Date: Fri, 29 Nov 2013 13:16:31 +0100
Message-ID: <CACRpkdZJTpUDO6ZxrUS+02docY8wDyz0eZP3AM3qA_WwoaKAbw@mail.gmail.com>
References: <1385417755-21776-1-git-send-email-paul.drews@intel.com>
	<1595199.2xkkMsZdTD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1595199.2xkkMsZdTD@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Paul Drews <paul.drews@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 28, 2013 at 2:29 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, November 25, 2013 02:15:55 PM Paul Drews wrote:
>> This adds the new ACPI ID (INT33FC) for the BayTrail GPIO
>> banks as seen on a BayTrail M System-On-Chip platform.  This
>> ACPI ID is used by the BayTrail GPIO (pinctrl) driver to
>> manage the Low Power Subsystem (LPSS).
>>
>> Signed-off-by: Paul Drews <paul.drews@intel.com>
>
> Linus, any objections to this?  If not, I'll take it for 3.14.

Go ahead,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
