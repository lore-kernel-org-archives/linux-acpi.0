From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] acpi: Fix format string type mistakes
Date: Fri, 16 Dec 2016 15:04:22 -0800
Message-ID: <CAGXu5jKc35OzaPCR-f34THEkmE4ZbPP-cW2BVFzTgPYVmT_5dw@mail.gmail.com>
References: <20161216215137.GA96800@beast> <CAJZ5v0h-xUXNHgr5x4ZYRAvsUZDip65aYCPVPeZ3E9=djcpQnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h-xUXNHgr5x4ZYRAvsUZDip65aYCPVPeZ3E9=djcpQnA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Emese Revfy <re.emese@gmail.com>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 16, 2016 at 2:36 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Dec 16, 2016 at 10:51 PM, Kees Cook <keescook@chromium.org> wrote:
>> From: Emese Revfy <re.emese@gmail.com>
>>
>> This adds the missing __printf attribute which allows compile time
>> format string checking (and will be used by the coming initify gcc
>> plugin). Additionally, this fixes the warnings exposed by the attribute.
>>
>> Signed-off-by: Emese Revfy <re.emese@gmail.com>
>> [kees: split scsi/acpi, merged attr and fix, new commit messages]
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This modifies code that we get from an external projiect (ACPICA) and
> the bugs should be fixed in there in the first place.

Who should get CCed?

> Moreover, I'm not sure if adding __printf in acpiosxf.h is a good idea.

Why not? This is going to be needed by the initify plugin to do
correct detection of what's being passed around to functions...

-Kees

-- 
Kees Cook
Nexus Security
