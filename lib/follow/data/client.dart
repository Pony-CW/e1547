import 'package:e1547/client/client.dart';
import 'package:e1547/pool/pool.dart';
import 'package:e1547/post/post.dart';
import 'package:e1547/tag/data/client.dart';

abstract class FollowClient
    implements
        Client,
        PostOrderedClient,
        PostTaggedClient,
        TagAliasClient,
        PoolClient {}
