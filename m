From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: status update for current development
	on ASUS M2N
Date: Mon, 27 Sep 2004 20:11:41 +1000
Sender: softwaresuspend-devel-admin@berlios.de
Message-ID: <1096279213.4222.5.camel@laptop.cunninghams>
References: <m3lleww12c.fsf@brain.gnuhh.org>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <softwaresuspend-devel-admin@lists.berlios.de>
In-Reply-To: <m3lleww12c.fsf@brain.gnuhh.org>
Errors-To: softwaresuspend-devel-admin@berlios.de
List-Help: <mailto:softwaresuspend-devel-request@lists.berlios.de?subject=help>
List-Post: <mailto:softwaresuspend-devel@lists.berlios.de>
List-Subscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=subscribe>
List-Unsubscribe: <http://lists.berlios.de/mailman/listinfo/softwaresuspend-devel>,
	<mailto:softwaresuspend-devel-request@lists.berlios.de?subject=unsubscribe>
List-Archive: <http://lists.berlios.de/pipermail/softwaresuspend-devel/>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: ACPI List <acpi-devel@lists.sourceforge.net>, SoftwareSuspend-Devel <softwaresuspend-devel@lists.berlios.de>
List-Id: linux-acpi@vger.kernel.org

Hi Georg.

On Mon, 2004-09-27 at 18:47, Georg C. F. Greve wrote:
> The kacpid process seems to run wild and eat all available time, it
> looks like some kind of wild loop, but there is no output. I can
> normally shut the machine down -- although it takes a while.

Could I get you to compile kdb in as well. If you then press the Sys Rq
key when the CPU is being chewed, you should be able to use ps and btp
<process number> to get an idea of what is going on. There have been
thermal issues reported on the help list. They might be related. I'll
see if I can reproduce anything on my desktop.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.
