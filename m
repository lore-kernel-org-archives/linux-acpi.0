From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Sat, 05 Feb 2005 02:07:57 +0100
Message-ID: <42041C6D.4000905@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz> <Pine.LNX.4.56.0502042206090.26459@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.56.0502042206090.26459-nGpKsS7K33UUkNsaar8edxWb9i9o6OzJ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Simmons <jsimmons-4a22rCvIain6YmnWEzS1oti2O/JbrIOy@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

James Simmons schrieb:
>>>int video_helper(struct video_actions *what_to_do)
>>
>>I do not know, synchronously executing userland code from kernel seems
>>like wrong thing to do.
> 
> I'm not a fan for this either. The good news is most graphics cards don't 
> require these tricks. The only ones that do are the ix86 cards. The real 
> solution would be if the hradware vendors open the parts of the spec to do 
> what we need. Many of the older cards could be supported in this way if we
> talk to the vendors. They shouldn't care if the specs are released anymore. 
> The problem would be the latest Radeon card and NVIDIA cards which 
> unfortunely are the most common cards for x86 platforms ;-(

Well, either you call userspace synchronously or you crash on resume.
I know what I prefer. And this synchronous call isn't so bad because
it comes with a timeout. So whatever the userspace program does, after
two seconds the kernel will continue unaffected. Once you execute the code
asynchronously, you get nondeterministic behaviour. That's sure fun for
filling up your random pool, but I wouldn't trust my data to such a system.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
