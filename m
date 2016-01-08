From: Michal Marek <mmarek@suse.cz>
Subject: Re: Thoughts about introducing OPTIMIZATION_CFLAG
Date: Fri, 8 Jan 2016 13:30:22 +0100
Message-ID: <568FABDE.4010004@suse.cz>
References: <CA+icZUVEs_+XiWeqtJ+34HBSx5LJYyEgoo2DLFzVr6yc9oxx2Q@mail.gmail.com>
 <20160104113318.700a9ed0@lxorguk.ukuu.org.uk>
 <CA+icZUUAoG0VeY06r_=c7aNGbuSkHp5VRHNSB=bQGTiTHShGtQ@mail.gmail.com>
 <568AF421.7050305@suse.cz>
 <CA+icZUWxfbPN4URoVdBAwm22sdKqGmTtiNBEg-KoHi-vgGqzqg@mail.gmail.com>
 <568F9E1E.7030406@suse.cz>
 <CA+icZUWMX_C2ME7BT0gkdbPPao_59=ddg6+2E9T3OMfZ0++OQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CA+icZUWMX_C2ME7BT0gkdbPPao_59=ddg6+2E9T3OMfZ0++OQA@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, linux-kbuild@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 2016-01-08 12:49, Sedat Dilek wrote:
> On Fri, Jan 8, 2016 at 12:31 PM, Michal Marek <mmarek@suse.cz> wrote:
>> On 2016-01-08 11:03, Sedat Dilek wrote:
>>> On Mon, Jan 4, 2016 at 11:37 PM, Michal Marek <mmarek@suse.cz> wrote:
>>>> Dne 4.1.2016 v 12:47 Sedat Dilek napsal(a):
>>> gcc-4.9 "$@"
>>> - EOF -
>>>
>>> According to your statement passing an optlevel here in this script
>>> will never-ever be recognized - as it is at the begin-of-(make)-line.
>>
>> Pass it as the last argument.
>>
> 
> How do I do that?

gcc-4.9 "$@" -O3

Michal

