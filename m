From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: scripts/mod/file2alias.c cross compile problem
Date: Thu, 2 Aug 2007 10:40:14 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A02156CC1@scsmsx411.amr.corp.intel.com>
References: <jewswdvqpt.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <jewswdvqpt.fsf@sykes.suse.de>
Sender: linux-ia64-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: trenn@suse.de, Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>, Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>>>  struct acpi_device_id {
>>>  	__u8 id[ACPI_ID_LEN];
>>> +	__u8 dummy[FILLUP_LEN];
>>>  	kernel_ulong_t driver_data;
>>>  };
>>
>> What's so special about this structure that we get an error?
>
> It's special because it's a device_id structure, and those structures
> must come out identical using either the host or the target compiler.

That didn't help me understand.  Are device_id structures visible
in some user-level API?  If so, then I can see why they'd need to
be the same (but then I'd be confused why this structure uses a
"kernel_ulong_t" type).

-Tony
