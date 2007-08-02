From: Andreas Schwab <schwab@suse.de>
Subject: Re: scripts/mod/file2alias.c cross compile problem
Date: Thu, 02 Aug 2007 18:36:14 +0200
Message-ID: <jewswdvqpt.fsf@sykes.suse.de>
References: <617E1C2C70743745A92448908E030B2A0211AFF0@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <617E1C2C70743745A92448908E030B2A0211AFF0@scsmsx411.amr.corp.intel.com>
	(Tony Luck's message of "Thu\, 2 Aug 2007 09\:25\:58 -0700")
Sender: linux-ia64-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: trenn@suse.de, Adrian Bunk <bunk@stusta.de>, Sam Ravnborg <sam@ravnborg.org>, Jan Dittmer <jdi@l4x.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

>> +#define FILLUP_LEN	7 /* dirty fix for i386 -> 64bit cross-compilati=
on */
>> =20
>>  struct acpi_device_id {
>>  	__u8 id[ACPI_ID_LEN];
>> +	__u8 dummy[FILLUP_LEN];
>>  	kernel_ulong_t driver_data;
>>  };
>
> What's so special about this structure that we get an error?

It's special because it's a device_id structure, and those structures
must come out identical using either the host or the target compiler.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
