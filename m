From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V5 2/7] ACPI / bus: Introduce acpi_get_match_data()
 function
Date: Mon, 4 Dec 2017 17:01:15 -0500
Message-ID: <af5279fd-8e7b-ab17-37f1-1ca0ebbbc2f5@codeaurora.org>
References: <1512188864-773-1-git-send-email-okaya@codeaurora.org>
 <1512188864-773-3-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0gCkY80+A=cZKzhKhxKObSgqN3k1JGgGQgW5cwRSvqt_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbdLDWBS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 17:01:18 -0500
In-Reply-To: <CAJZ5v0gCkY80+A=cZKzhKhxKObSgqN3k1JGgGQgW5cwRSvqt_Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 12/4/2017 4:59 PM, Rafael J. Wysocki wrote:
> On Sat, Dec 2, 2017 at 5:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> OF has of_device_get_match_data() function to extract driver specific data
>> structure. Add a similar function for ACPI.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> Haven't I ACKed this already?
> 
> Anyway, please resend the whole series with a CC to linux-acpi.

Yeah, you acked the previous one. Then, I changed the calling parameter from
struct device to struct acpi_device and removed your ACK.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
