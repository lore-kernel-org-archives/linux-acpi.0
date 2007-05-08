From: Ross Patterson <me@rpatterson.net>
Subject: Re: Toshiba Setellite U205-S5067 Suspend to RAM
Date: Tue, 08 May 2007 14:59:11 -0700
Message-ID: <87ejlrrn80.fsf@superfluity.lefae.org>
References: <1178503360.5988.22.camel@trinity>
	<87wszlnumj.fsf@superfluity.lefae.org>
	<87hcqntd5z.fsf@superfluity.lefae.org>
	<200705082133.23094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Tuesday, 8 May 2007 19:53, Ross Patterson wrote:
>> Ross Patterson <me@rpatterson.net> writes:
>> 
>> > Ross Patterson <me@rpatterson.net> writes:
>> >
>> >> "Paulo J. S. Silva" <pjssilva@ime.usp.br> writes:
>> >>
>> >>> I am not a kernel hacker, but I have tried to add some printk as
>> >>> suggested by Pavel (I haven't used udelay, I was not sure what it did
>> >>> (Is there a good explanation anywhere?). I added one printk to
>> >>> state_store function in main.c file (in kernel/power/ directory of
>> >>> course) to make sure that the process was starting, and many in
>> >>> enter_state function.
>> >>>
>> >>> What I could see, at first, is that something was taking long while the
>> >>> kernel was trying to disable the non-boot CPU. Here is the important log
>> >>> snippet (mine printk start with ****):
>> >>>
>> >>>
>> >>>> May  6 12:44:44 trinity kernel: [  704.412000] ****Receiving request to power sa
>> >>>> ve: mem
>> >>>> May  6 12:44:44 trinity kernel: [  704.412000] .
>> >>>> May  6 12:44:44 trinity kernel: [  704.412000] **** starting enter_state.
>> >>>> May  6 12:44:44 trinity kernel: [  704.412000] **** Preparing system for mem sle
>> >>>> ep
>> >>>> May  6 12:44:44 trinity kernel: [  704.416000] Disabling non-boot CPUs ...
>> >>>> May  6 12:44:44 trinity kernel: [  704.552000] CPU 1 is now offline
>> >>>> May  6 12:44:44 trinity kernel: [  704.552000] SMP alternatives: switching to UP
>> >>>>  code
>> >>>> May  6 12:55:00 trinity kernel: [  704.552000] CPU1 is down
>> >>>
>> >>> You see? Something took 10 minutes between the last two lines.
>> >>>
>> >>> I then thought that SMP was the problem. I have then disabled the second
>> >>> CPU during boot using "noapic nosmp" options. But I still get the same
>> >>> long wait before suspending. Moreover, something weird happens. There is
>> >>> no more delay in the sequence of messages related to suspend. But the
>> >>> whole sequence of messages, even the first sentence that says that the
>> >>> system is calling the function state_store, is only written to the disk
>> >>> when the system is waked up and not before the suspend take place. The
>> >>> same thing happen if I disable the second CPU in the bios, instead of
>> >>> using "noapic nosmp". What should I try now?
>> 
>> I was wondering if anyone has any thoughts on what we might try from
>> here?  I think there are at least two willing, if not knowledgable :),
>> testers here.
>
> Well, I'm afraid no one has any idea.  Otherwise, someone would have responded. ;-)
>
> I've added more appropriate lists for your problem report to the CC list.
> Also, it probably would be a good idea to file a bug report at
> http://bugzilla.kernel.org, in the ACPI->Power-Sleep-Wake category (please
> add my address to the bugzilla entry's CC list if you do that).

http://bugzilla.kernel.org/show_bug.cgi?id=8456

Thanks!

Ross

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
