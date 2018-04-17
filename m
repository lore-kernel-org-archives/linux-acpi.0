From: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH 2/3] ACPI: SPCR: Add support for AMD CT/SZ
Date: Mon, 16 Apr 2018 20:43:46 -0400
Message-ID: <01bc6f27-57aa-d8e9-934b-191a128543cf@jonmasters.org>
References: <20180314003655.12141-1-djkurtz@chromium.org>
 <20180314003655.12141-3-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314003655.12141-3-djkurtz@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 03/13/2018 08:36 PM, Daniel Kurtz wrote:
> AMD Carrizo / Stoneyridge use a DesignWare 8250 UART that uses a special
> earlycon setup handler to configure its input clock in order to compute
> baud rate divisor registers.
> Detect them by examining the OEMID field in the SPCR header, and pass
> then pass uart type amdcz to earlycon.

FYI I spoke with Microsoft some time ago about standardizing the ability
to convey non-standard baud rates in the SPCR. If you're interested in
driving, I can put you in touch with the right person over there.

Jon.

-- 
Computer Architect
